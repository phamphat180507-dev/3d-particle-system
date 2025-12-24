<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3D Particle Interaction</title>
    <style>
        body { margin: 0; overflow: hidden; background: radial-gradient(circle, #1a1a2e, #000000); }
        canvas { display: block; }
    </style>
</head>
<body>

<script type="importmap">
    { "imports": { "three": "https://unpkg.com/three@0.160.0/build/three.module.js" } }
</script>

<script type="module">
    import * as THREE from 'three';

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(renderer.domElement);

    // Cấu hình hạt
    const count = 8000;
    const pos = new Float32Array(count * 3);
    const originalPos = new Float32Array(count * 3);
    const mouse = new THREE.Vector2(-100, -100);

    for (let i = 0; i < count * 3; i++) {
        pos[i] = (Math.random() - 0.5) * 12;
        originalPos[i] = pos[i];
    }

    const geometry = new THREE.BufferGeometry();
    geometry.setAttribute('position', new THREE.BufferAttribute(pos, 3));

    const material = new THREE.PointsMaterial({
        size: 0.015,
        color: 0x00d4ff,
        transparent: true,
        blending: THREE.AdditiveBlending
    });

    const points = new THREE.Points(geometry, material);
    scene.add(points);
    camera.position.z = 5;

    // Lắng nghe sự kiện chuột
    window.addEventListener('mousemove', (e) => {
        mouse.x = (e.clientX / window.innerWidth) * 2 - 1;
        mouse.y = -(e.clientY / window.innerHeight) * 2 + 1;
    });

    // Vòng lặp cập nhật thời gian thực
    function animate() {
        requestAnimationFrame(animate);
        const positions = geometry.attributes.position.array;
        const time = performance.now() * 0.001;

        // Vector chuột trong không gian 3D (ước tính)
        const mx = mouse.x * 5;
        const my = mouse.y * 5;

        for (let i = 0; i < count; i++) {
            let ix = i * 3, iy = i * 3 + 1, iz = i * 3 + 2;

            // Hiệu ứng sóng tự nhiên
            positions[iz] = originalPos[iz] + Math.sin(time + originalPos[ix] * 0.5) * 0.5;

            // Tính tương tác với chuột
            let dx = positions[ix] - mx;
            let dy = positions[iy] - my;
            let dist = Math.sqrt(dx * dx + dy * dy);

            if (dist < 1.2) {
                let force = (1.2 - dist) / 1.2;
                positions[ix] += dx * force * 0.1;
                positions[iy] += dy * force * 0.1;
            } else {
                // Trở về vị trí cũ
                positions[ix] += (originalPos[ix] - positions[ix]) * 0.05;
                positions[iy] += (originalPos[iy] - positions[iy]) * 0.05;
            }
        }

        geometry.attributes.position.needsUpdate = true;
        points.rotation.y += 0.001;
        renderer.render(scene, camera);
    }

    window.addEventListener('resize', () => {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize(window.innerWidth, window.innerHeight);
    });

    animate();
</script>
</body>
</html>