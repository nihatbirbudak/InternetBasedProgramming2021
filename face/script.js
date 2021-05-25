const imageUpload = document.getElementById('imageUpload')

Promise.all([
  faceapi.nets.faceRecognitionNet.loadFromUri('/models'),
  faceapi.nets.faceLandmark68Net.loadFromUri('/models'),
  faceapi.nets.ssdMobilenetv1.loadFromUri('/models'),
]).then(start)

async function start() {
  const container = document.createElement('div')
  container.style.position = 'relative'
  document.body.append(container)
  imageUpload.addEventListener('change', async () => {
    const image = await faceapi.bufferToImage(imageUpload.files[0])
    image.setAttribute("usemap","#map")
    container.append(image)
    const canvas = faceapi.createCanvasFromMedia(image)
    const displaySize = { width: image.width, height: image.height }
    faceapi.matchDimensions(canvas, displaySize)
    const detections = await faceapi.detectAllFaces(image).withFaceLandmarks().withFaceDescriptors()
    const resizedDetections = faceapi.resizeResults(detections, displaySize)
    const divInput = document.createElement("div")
    divInput.setAttribute("class","face-inputs")
    document.body.append(divInput)
    i = 0
    resizedDetections.forEach(detection => {
      const box = detection.detection.box
      const area = document.createElement('div')
      divInput.className = "row"
      area.style.top = (box.y -10) + "px"
      area.style.left = (box.x -10) + "px"
      area.setAttribute("class","box-user-face")
      area.setAttribute("id",`face-${i}`)
      area.innerHTML = i
      area.style.color = "white"
      container.append(area)
      const lable = document.createElement('label')
      lable.setAttribute("name","`face-${i}`")
      lable.innerHTML = i
      const input = document.createElement("input")
      input.setAttribute("name",`face-${i}`)
      input.setAttribute("type","text")
      input.setAttribute("value","none")
      divInput.append(lable)
      divInput.append(input)
      i = i + 1
    })
  })
}



