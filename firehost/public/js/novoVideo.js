function enviaDados($dados){
	var citiesRef = db.collection("plataforma"); // Cria nova categoria se nao existir anteriormente
	var recebido = $dados;
	console.log('parametro: '+recebido);

				citiesRef.doc($dados).set({
				    video: $dados});
}
		//Pega os elementos
			const txtVideo  = document.getElementById('txtVideo');
			
			
		// Eventos do bot'ao
			btnEnviar.addEventListener('click', e => {

			// Pega video e senha
			const video = txtVideo.value;
			console.log(video);
			enviaDados(video);	

				
						
			
		});
