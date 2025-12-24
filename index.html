<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3D Hand Particles - Fixed Version</title>
    <style>
        body { margin: 0; overflow: hidden; background: #000; font-family: 'Segoe UI', sans-serif; }
        #controls { position: absolute; top: 20px; left: 20px; z-index: 100; display: flex; gap: 10px; }
        button { background: rgba(0, 212, 255, 0.2); border: 1px solid #00d4ff; color: #00d4ff; padding: 10px 15px; cursor: pointer; border-radius: 5px; font-weight: bold; }
        button:hover { background: #00d4ff; color: black; }
        #status { position: absolute; top: 75px; left: 20px; color: #fff; background: rgba(0,0,0,0.5); padding: 5px 10px; border-radius: 4px; z-index: 100; }
        #video-container { position: absolute; bottom: 10px; right: 10px; width: 180px; height: 135px; border: 2px solid #333; border-radius: 10px; overflow: hidden; transform: scaleX(-1); z-index: 10; }
        video { width: 100%; height: 100%; object-fit: cover; }
    </style>
</head>
<body>
    <div id="controls">
        <button onclick="window.setMode('particles')">CHẾ ĐỘ HẠT</button>
        <button onclick="window.setMode('neural')">CHẾ ĐỘ MẠNG LƯỚI</button>
    </div>
    <div id="status">Đang tải thư viện AI...</div>
    <div id="video-container"><video id="webcam" autoplay playsinline></video></div>

    <script type="importmap">
        { "imports": { "three": "https://unpkg.com/three@0.160.0/build/three.module.js" } }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/@mediapipe/hands@0.4.1646424915/hands.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@mediapipe/camera_utils/camera_utils.js"></script>

    <script type="module">
        import * as THREE from 'three';

        // --- CẤU HÌNH THREE.JS ---
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ antialias: true, powerPreference: "high-performance" });
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(window.devicePixelRatio);
        document.body.appendChild(renderer.domElement);
        camera.position.z = 8;

        let currentMode = 'particles';
        const handData = { x: 0, y: 0, isGrabbing: false, active: false };

        // 1. Chế độ Hạt
        const pCount = 6000;
        const pGeom = new THREE.BufferGeometry();
        const pPos = new Float32Array(pCount * 3);
        const pOriginal = new Float32Array(pCount * 3);
        for(let i=0; i<pCount*3; i++) { pPos[i] = (Math.random()-0.5)*18; pOriginal[i] = pPos[i]; }
        pGeom.setAttribute('position', new THREE.BufferAttribute(pPos, 3));
        const pMat = new THREE.PointsMaterial({ size: 0.03, color: 0x00d4ff, blending: THREE.AdditiveBlending, transparent: true, opacity: 0.8 });
        const pMesh = new THREE.Points(pGeom, pMat);
        scene.add(pMesh);

        // 2. Chế độ Mạng lưới
        const nLinesGeom = new THREE.BufferGeometry();
        const nLinesMat = new THREE.LineBasicMaterial({ color: 0x00ffcc, transparent: true, opacity: 0.2 });
        const nLines = new THREE.LineSegments(nLinesGeom, nLinesMat);
        scene.add(nLines);
        nLines.visible = false;

        window.setMode = (m) => {
            currentMode = m;
            pMesh.visible = (m === 'particles');
            nLines.visible = (m === 'neural');
        };

        // --- NHẬN DIỆN TAY ---
        async function setupAI() {
            const status = document.getElementById('status');
            try {
                const hands = new Hands({
                    locateFile: (file) => `https://cdn.jsdelivr.net/npm/@mediapipe/hands@0.4.1646424915/${file}`
                });

                hands.setOptions({
                    maxNumHands: 1,
                    modelComplexity: 1,
                    minDetectionConfidence: 0.5,
                    minTrackingConfidence: 0.5
                });

                hands.onResults((res) => {
                    if (res.multiHandLandmarks && res.multiHandLandmarks.length > 0) {
                        handData.active = true;
                        const lm = res.multiHandLandmarks[0];
                        // Tính toán nắm tay dựa trên khoảng cách ngón trỏ và cổ tay
                        const d = Math.sqrt(Math.pow(lm[8].x-lm[0].x,2) + Math.pow(lm[8].y-lm[0].y,2));
                        handData.isGrabbing = d < 0.35;
                        handData.x = (1 - lm[9].x) * 2 - 1;
                        handData.y = -(lm[9].y * 2 - 1);
                        status.innerText = handData.isGrabbing ? "TRẠNG THÁI: HÚT (NẮM TAY)" : "TRẠNG THÁI: ĐẨY (XÒE TAY)";
                    } else {
                        handData.active = false;
                        status.innerText = "HÃY GIƠ TAY TRƯỚC CAMERA";
                    }
                });

                const vid = document.getElementById('webcam');
                const cam = new Camera(vid, {
                    onFrame: async () => { await hands.send({ image: vid }); },
                    width: 640, height: 480
                });
                cam.start();
                status.innerText = "Camera đã sẵn sàng!";
            } catch (e) {
                status.innerText = "Lỗi khởi tạo AI. Vui lòng tải lại trang.";
                console.error(e);
            }
        }

        // --- VÒNG LẶP VẬT LÝ ---
        function animate() {
            requestAnimationFrame(animate);
            const hx = handData.x * 10, hy = handData.y * 7;
            const pos = pGeom.attributes.position.array;

            if (currentMode === 'particles') {
                for(let i=0; i<pCount; i++) {
                    let ix=i*3, iy=i*3+1, iz=i*3+2;
                    let dx = pos[ix]-hx, dy = pos[iy]-hy;
                    let dist = Math.sqrt(dx*dx + dy*dy);

                    if(handData.active && dist < 4) {
                        let f = handData.isGrabbing ? -0.1 : 0.2;
                        pos[ix] += dx * f * 0.1;
                        pos[iy] += dy * f * 0.1;
                    } else {
                        pos[ix] += (pOriginal[ix] - pos[ix]) * 0.05;
                        pos[iy] += (pOriginal[iy] - pos[iy]) * 0.05;
                    }
                }
                pGeom.attributes.position.needsUpdate = true;
            } else if (currentMode === 'neural') {
                const linePoints = [];
                // Lấy 150 hạt đầu tiên để làm mạng lưới (để mượt hơn)
                for(let i=0; i<200; i++) {
                    let ix=i*3, iy=i*3+1, iz=i*3+2;
                    if(handData.active) {
                        let dx = pos[ix]-hx, dy = pos[iy]-hy;
                        if(Math.sqrt(dx*dx+dy*dy) < 3) {
                            let f = handData.isGrabbing ? -0.05 : 0.05;
                            pos[ix] += dx*f; pos[iy] += dy*f;
                        }
                    }
                    for(let j=i+1; j<200; j++) {
                        let jx=j*3, jy=j*3+1, jz=j*3+2;
                        let dist = Math.sqrt(Math.pow(pos[ix]-pos[jx],2) + Math.pow(pos[iy]-pos[jy],2));
                        if(dist < 2.5) {
                            linePoints.push(pos[ix], pos[iy], pos[iz], pos[jx], pos[jy], pos[jz]);
                        }
                    }
                }
                nLinesGeom.setAttribute('position', new THREE.Float32BufferAttribute(linePoints, 3));
                pGeom.attributes.position.needsUpdate = true;
            }
            
            pMesh.rotation.y += 0.001;
            nLines.rotation.y += 0.001;
            renderer.render(scene, camera);
        }

        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });

        setupAI();
        animate();
    </script>
</body>
</html>
