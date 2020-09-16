if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
document.addEventListener('DOMContentLoaded', function(){
  const imageList = document.getElementById('image-list');

  const defaultImage = document.getElementById('default-image');
  document.getElementById('item-image').addEventListener('change', function(e){
    console.log(e);
    const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
        if(defaultImage) {
          defaultImage.remove();
        }
      }
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
     const imageElement = document.createElement('div');
     const blobImage = document.createElement('img');
     blobImage.setAttribute('src', blob);
     imageElement.appendChild(blobImage);
    imageList.appendChild(imageElement);
    blobImage.setAttribute('class', 'preview-image');
  });
});
}
