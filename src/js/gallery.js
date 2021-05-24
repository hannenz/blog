(function() {

	let cockpitUrl = 'https://hannenz.de/cockpit/';

	let token = '0e660fb8369a392daf0edd1204a1d6';
	let url = cockpitUrl + 'api/collections/get/Galerien?token=' + token;
	let contentDiv = document.getElementById('content');
	let headlineTag = document.querySelector('.gallery .headline');
	contentDiv.innerHTML = '';
	fetch(url)
		.then(response => response.json())
		.then(data => {

			let galleryData = data.entries[0];
			headlineTag.innerText = galleryData.title;

			galleryData.images.forEach((entry, i) => {

				var image = new Image();
				image.setAttribute('alt', entry.alt);
				image.setAttribute('loading', 'lazy');
				let figure = document.createElement('figure');
				figure.appendChild(image);
				if (entry.meta.title.length > 0) {
					let caption = document.createElement('figcaption');
					caption.innerHTML = entry.meta.title;
					figure.appendChild(caption);
				}
				contentDiv.appendChild(figure);
				image.src = 'https://www.hannenz.de' + entry.path;
			});
		})
	
})();
