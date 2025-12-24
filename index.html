<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>3D Magic Particles - Color Edition</title>
    <style>
        body { margin: 0; overflow: hidden; background: #000; }
        #status { position: absolute; top: 20px; left: 20px; color: white; font-family: 'Courier New', Courier, monospace; pointer-events: none; }
        #video-container { position: absolute; bottom: 10px; right: 10px; width: 150px; height: 110px; border: 1px solid #555; border-radius: 5px; overflow: hidden; transform: scaleX(-1); opacity: 0.3; }
        video { width: 100%; height: 100%; object-fit: cover; }
    </style>
</head>
<body>
    <div id="status">Đang khởi động phép thuật...</div>
    <div id="video-container"><video id="webcam" autoplay></video></div>

    <script type="importmap">
        { "imports": { "three": "https://unpkg.com/three@0.160.0/build/three.module.js" } }
    </script>

    <script type="module">
        import * as THREE from 'three';

        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize(window.innerWidth, window.innerHeight);
        document.body.appendChild(renderer.domElement);

        // --- CẤU HÌNH HẠT & MÀU SẮC ---
        const count = 15000;
        const pos = new Float32Array(count * 3);
        const colors = new Float32Array(count * 3); // Mảng chứa màu RGB cho từng hạt
        const originalPos = new Float32Array(count * 3);
        const handData = { x: 0, y: 0, isGrabbing: false, active: false };

        const colorObj = new THREE.Color();

        for (let i = 0; i < count; i++) {
            let ix = i * 3;
            // Vị trí
            pos[ix] = (Math.random() - 0.5) * 15;
            pos[ix+1] = (Math.random() - 0.5) * 15;
            pos[ix+2] = (Math.random() - 0.5) * 15;
            originalPos.set([pos[ix], pos[ix+1], pos[ix+2]], ix);

            // Tạo màu sắc ban đầu (Gradient dựa trên vị trí X)
            colorObj.setHSL(Math.abs(pos[ix] / 15), 0.8, 0.6); 
            colors[ix] = colorObj.r;
            colors[ix+1] = colorObj.g;
            colors[ix+2] = colorObj.b;
        }

        const geometry = new THREE.BufferGeometry();
        geometry.setAttribute('position', new THREE.BufferAttribute(pos, 3));
        geometry.setAttribute('color', new THREE.BufferAttribute(colors, 3)); // Kích hoạt màu đỉnh

        const material = new THREE.PointsMaterial({ 
            size: 0.025, 
            vertexColors: true, // Cho phép sử dụng mảng màu đã tạo
            transparent: true, 
            blending: THREE.AdditiveBlending,
            depthWrite: false 
        });

        const points = new THREE.Points(geometry, material);
        scene.add(points);
        camera.position.z = 7;

        // --- NHẬN DIỆN TAY (MediaPipe) ---
        async function setupHandTracking() {
            const hands = new window.Hands({
                locateFile: (file) => `https://cdn.jsdelivr.net/npm/@mediapipe/hands/${file}`
            });
            hands.setOptions({ maxNumHands: 1, modelComplexity: 1, minDetectionConfidence: 0.6 });

            hands.onResults((results) => {
                const statusEl = document.getElementById('status');
                if (results.multiHandLandmarks && results.multiHandLandmarks.length > 0) {
                    handData.active = true;
                    const lm = results.multiHandLandmarks[0];
                    const wrist = lm[0];
                    const tips = [lm[8], lm[12], lm[16], lm[20]];
                    
                    let d = 0;
                    tips.forEach(t => d += Math.sqrt(Math.pow(t.x-wrist.x,2) + Math.pow(t.y-wrist.y,2)));
                    handData.isGrabbing = (d/4) < 0.3;
                    handData.x = (1 - lm[9].x) * 2 - 1;
                    handData.y = -(lm[9].y * 2 - 1);
                    
                    statusEl.innerText = handData.isGrabbing ? "TRẠNG THÁI: HÚT VÀ ĐỔI MÀU ĐỎ" : "TRẠNG THÁI: ĐẨY VÀ MÀU XANH";
                } else {
                    handData.active = false;
                    statusEl.innerText = "HÃY GIƠ TAY LÊN";
                }
            });

            const videoElement = document.getElementById('webcam');
            const stream = await navigator.mediaDevices.getUserMedia({ video: true });
            videoElement.srcObject = stream;
            const cameraUtils = new window.Camera(videoElement, {
                onFrame: async () => { await hands.send({image: videoElement}); },
                width: 640, height: 480
            });
            cameraUtils.start();
        }

        // --- VÒNG LẶP RENDER ---
        function animate() {
            requestAnimationFrame(animate);
            const p = geometry.attributes.position.array;
            const c = geometry.attributes.color.array;
            const hx = handData.x * 8;
            const hy = handData.y * 6;

            for (let i = 0; i < count; i++) {
                let ix = i * 3, iy = i * 3 + 1, iz = i * 3 + 2;
                let dx = p[ix] - hx;
                let dy = p[iy] - hy;
                let dist = Math.sqrt(dx*dx + dy*dy);

                if (handData.active && dist < 3.5) {
                    let force = (3.5 - dist) / 3.5;
                    let speed = handData.isGrabbing ? -0.15 : 0.25;
                    p[ix] += dx * force * speed;
                    p[iy] += dy * force * speed;

                    // ĐỔI MÀU KHI CHẠM TAY
                    if (handData.isGrabbing) {
                        // Nắm tay -> Chuyển dần sang màu Đỏ/Cam
                        c[ix] += (1.0 - c[ix]) * 0.1;
                        c[ix+1] += (0.2 - c[ix+1]) * 0.1;
                        c[ix+2] += (0.0 - c[ix+2]) * 0.1;
                    } else {
                        // Xòe tay -> Chuyển dần sang màu Xanh neon
                        c[ix] += (0.0 - c[ix]) * 0.1;
                        c[ix+1] += (0.8 - c[ix+1]) * 0.1;
                        c[ix+2] += (1.0 - c[ix+2]) * 0.1;
                    }
                } else {
                    // Về vị trí cũ & Màu gốc (Gradient Tím/Xanh)
                    p[ix] += (originalPos[ix] - p[ix]) * 0.05;
                    p[iy] += (originalPos[iy] - p[iy]) * 0.05;
                    
                    let hue = Math.abs(originalPos[ix] / 15);
                    colorObj.setHSL(hue, 0.8, 0.5);
                    c[ix] += (colorObj.r - c[ix]) * 0.02;
                    c[ix+1] += (colorObj.g - c[ix+1]) * 0.02;
                    c[ix+2] += (colorObj.b - c[ix+2]) * 0.02;
                }
            }
            
            geometry.attributes.position.needsUpdate = true;
            geometry.attributes.color.needsUpdate = true;
            points.rotation.z += 0.001;
            renderer.render(scene, camera);
        }

        const loadScript = (src) => new Promise(res => {
            const s = document.createElement('script'); s.src = src; s.onload = res; document.head.appendChild(s);
        });

        async function init() {
            await loadScript("https://cdn.jsdelivr.net/npm/@mediapipe/hands/hands.js");
            await loadScript("https://cdn.jsdelivr.net/npm/@mediapipe/camera_utils/camera_utils.js");
            setupHandTracking();
            animate();
        }
        init();

        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });
    </script>
</body>
</html>
