$ ->
#----Menu
	responsiveMenuFtc = ->
		if window.innerWidth > 550
			$('header .responsiveMenu').css display: 'none', opacity: 1
			$('header li').css display: 'inline-block', opacity: 1

			$(window).on
				'scroll.Scrolling' : ->
					scrollTop = $(window).scrollTop()
					positionHome = $('#home').position().top-100
					positionAbout = $('#about').position().top-100
					positionCompetence = $('#competence').position().top-100
					positionPortfolio = $('#portfolio').position().top-80-100
					positionContact = $('#cv').position().top-100

					if scrollTop >= positionHome && scrollTop < positionAbout
						size = ($('header li:eq(0)').width())-50
						left = 25
						TweenMax.to 'header span', 1.5, width: size, left: left

					if scrollTop >= positionAbout && scrollTop < positionCompetence
						size = ($('header li:eq(1)').width())-50
						left = ($('header li:eq(0)').width())+30
						TweenMax.to 'header span', 1.5, width: size, left: left

					if scrollTop >= positionCompetence && scrollTop < positionPortfolio
						size = ($('header li:eq(2)').width())-50
						left = ($('header li:eq(0)').width())+($('header li:eq(1)').width())+33
						TweenMax.to 'header span', 1.5, width: size, left: left

					if scrollTop >= positionPortfolio && scrollTop < positionContact
						size = ($('header li:eq(3)').width())-50
						left = ($('header li:eq(0)').width())+($('header li:eq(1)').width())+($('header li:eq(2)').width())+37
						TweenMax.to 'header span', 1.5, width: size, left: left

					if scrollTop >= positionContact
						size = ($('header li:eq(4)').width())-50
						left = ($('header li:eq(0)').width())+($('header li:eq(1)').width())+($('header li:eq(2)').width())+($('header li:eq(3)').width())+41
						TweenMax.to 'header span', 1.5, width: size, left: left
		if window.innerWidth < 550
			$('header .responsiveMenu').css display: 'block', opacity: 1
			$('header li').css display: 'none', opacity: 0

			checkMenuResp = false
			$('header ul, header .responsiveMenu').click ->
				if checkMenuResp
					$('header .responsiveMenu').css display : 'block'
					$('header li').animate opacity : 0, 'slow', ->
						$('header .responsiveMenu').animate opacity : 1, 'slow'
						$('header li').css display : 'none', opacity: 0
						checkMenuResp = false;
				else
					$('header li').css display : 'block', opacity: 0
					$('header .responsiveMenu').animate opacity : 0, 'slow', ->
						$('header li').animate opacity : 1, 'slow'
						$('header .responsiveMenu').css display : 'none'
						checkMenuResp = true;

	responsiveMenuFtc()
	$(window).resize ->
		$('header ul, header .responsiveMenu').unbind('click')
		$(window).unbind('scroll.Scrolling')
		responsiveMenuFtc()

#----Parallax
	verifBig = false
	verifSmall = false

	controller = new ScrollMagic

	# Home
	sceneCitation = new ScrollScene duration: 1000, triggerElement: '#home'
		.setTween TweenMax.fromTo '.title', 0.5, top: '10%',
			top: '80%'
		.addTo controller
		#.addIndicators zindex: 50000, suffix: 'home'	

	# Citation 
	timeLineCitationTop = new TimelineMax
	timeLineCitationTop.fromTo '#citation .decoWrapperTop', 1, 
		rotation: '45', ease: Linear.easeNone,
			rotation: '0', ease: Linear.easeNone
	timeLineCitationTop.fromTo '#citation .decoWrapperTop', 0.7, 
		top: '50%', ease: Linear.easeNone,
			top: '0', ease: Linear.easeNone

	timeLineCitationBot = new TimelineMax
	timeLineCitationBot.fromTo '#citation .decoWrapperBottom', 1, 
		rotation: '-45', ease: Linear.easeNone,
			rotation: '0', ease: Linear.easeNone
	timeLineCitationBot.fromTo '#citation .decoWrapperBottom', 0.7, 
		top: '50%', ease: Linear.easeNone,
			top: '100%', ease: Linear.easeNone

	tweenCitationTxt = TweenMax.fromTo '#citation .wrapper p', 1,
	opacity: '0',
		opacity: '1'
	'-=0.5'

	timeLineCitation = new TimelineMax
	timeLineCitation.add [timeLineCitationBot, timeLineCitationTop]
		.add tweenCitationTxt

	sceneCitation = new ScrollScene duration: 400, triggerElement: '#home .bottom'
		.setTween timeLineCitation
		.addTo controller
		#.addIndicators zindex: 50000, suffix: 'citation'

	# About
	timeLineAbout = new TimelineMax
	timeLineAbout.fromTo '#about', 1, 
			top: '200px',  ease: Linear.easeNone,
				top: '-75px',  ease: Linear.easeNone
	timeLineAbout.fromTo '#about .wrapper span', 1,
			right: '200%',  ease: Linear.easeNone,
				right: '100%',  ease: Linear.easeNone,
			'-=0.8'
	timeLineAbout.fromTo '#about .wrapper p', 0.5,
			opacity: '0',  ease: Linear.easeNone,
				opacity: '1',  ease: Linear.easeNone,
			'-=0.2'

	sceneAbout = new ScrollScene offset: -100, duration: 500, triggerElement: '#citation p'
		.setTween timeLineAbout
		.addTo controller
		#.addIndicators zindex: 50000, suffix: 'about'

	# Competance
	document.getElementById('competence').style.top = '-80px'
	if window.innerWidth > 979
		$('#competence #prog, #competence .floatLeft svg').css marginLeft: '-100px'
		$('#competence .floatLeft h2, #competence .floatRight h2').css opacity: '1'
		$('#competence #inGraph').css opacity: '0'

		timeLineCompSvg1 = new TimelineMax
		timeLineCompSvg1.from '#competence .floatLeft', .5, left: '-100%',  ease: Linear.easeNone
		timeLineCompSvg1.from '#competence #bgGraph', .6, delay: -.2, opacity: '0',  ease: Linear.easeNone
		timeLineCompSvg1.to '#competence #inGraph', .5, delay: -.4, opacity: '1',  ease: Linear.easeNone
		timeLineCompSvg1.from '#competence #bgGraph', .6, delay: -.6, rotation:"360", transformOrigin:"50% 50%"

		timeLineCompSvg2 = new TimelineMax
		timeLineCompSvg2.from '#competence .floatRight', .5, right: '-100%',  ease: Linear.easeNone
		timeLineCompSvg2.from '#competence #bgProg,#competence #inProg', .4, delay: -.2, opacity: '0',  ease: Linear.easeNone
		timeLineCompSvg2.from '#competence #bgProg .leftProg', .5, delay: -.4, transform: 'translate(10px,0)'
		timeLineCompSvg2.from '#competence #bgProg .rightProg', .5, delay: -.4, transform: 'translate(-10px,0)'
		timeLineCompSvg2.staggerFrom '#competence #inProg .nb', .7, opacity: '0', 0.08, '-=0.5'

		timeLineComp = new TimelineMax
		timeLineComp.add [timeLineCompSvg1, timeLineCompSvg2]	

		sceneComp = new ScrollScene offset: -100, duration: 800, triggerElement: '#competence'
			.setTween timeLineComp
			.addTo controller
			#.addIndicators zindex: 50000, suffix: 'competance'

		verifBig = true
	else
		$('#competence .floatLeft h2, #competence .floatRight h2').css opacity: '0'
		$('#competence .floatLeft span').css width: '0'
		$('#competence #progResp').css marginLeft: '230px'
		$('#competence .floatRight span').css marginLeft: '255px', width: '0'
		$('#competence .floatLeft svg').css marginLeft: '60px'
		$('#competence #prog').css marginLeft: '70px'

		timeLineCompRespSvg1 = new TimelineMax
		timeLineCompRespSvg1.from '#competence .floatLeft svg', 1.4, marginLeft: '-150'
		timeLineCompRespSvg1.to '#competence .floatLeft span', 1.4, delay: -1.4, width: '210'
		timeLineCompRespSvg1.to '#competence .floatLeft h2', 0.5, delay: -0.5, opacity: '1'

		sceneCompRespSvg1 = new ScrollScene duration: 300, triggerElement: '#competence'
			.setTween timeLineCompRespSvg1
			.addTo controller
			#.addIndicators zindex: 50000, suffix: 'competenceRespSVG1'

		timeLineCompRespSvg2 = new TimelineMax
		timeLineCompRespSvg2.from '#competence #prog', 1.4, marginLeft: '-70'
		timeLineCompRespSvg2.to '#competence #progResp', 1.4, delay: -1.4,  marginLeft: '80'
		timeLineCompRespSvg2.to '#competence .floatRight span', 1.4, delay: -1.4,  marginLeft: '108', width: '285'
		timeLineCompRespSvg2.to '#competence .floatRight h2', 0.5, delay: -0.5, opacity: '1'

		sceneCompRespSvg2 = new ScrollScene duration: 300, triggerElement: '#competence .floatRight'
			.setTween timeLineCompRespSvg2
			.addTo controller

		verifSmall = true

	# Competance Fix Anim Rezise
	$(window).resize ->
		if window.innerWidth > 979
			if verifSmall
				verifSmall = false
				controller.removeScene [sceneCompRespSvg2, sceneCompRespSvg1]

				$('#competence #prog, #competence .floatLeft svg').css marginLeft: '-100px'
				$('#competence .floatLeft h2, #competence .floatRight h2').css opacity: '1'
				$('#competence #inGraph').css opacity: '0'

				tweenComp1 = TweenMax.from '#competence .floatLeft', .1, left: '-100%',  ease: Linear.easeNone
				tweenComp2 = TweenMax.from '#competence .floatRight', .1, right: '-100%',  ease: Linear.easeNone

				timeLineCompSvg1 = new TimelineMax
				timeLineCompSvg1.from '#competence #bgGraph', .6, opacity: '0',  ease: Linear.easeNone
				timeLineCompSvg1.to '#competence #inGraph', .5, delay: -.4, opacity: '1',  ease: Linear.easeNone
				timeLineCompSvg1.from '#competence #bgGraph', .8, delay: -.6, rotation:"360", transformOrigin:"50% 50%"

				timeLineCompSvg2 = new TimelineMax
				timeLineCompSvg2.from '#competence #bgProg,#competence #inProg', .6, opacity: '0',  ease: Linear.easeNone
				timeLineCompSvg2.from '#competence #bgProg .leftProg', .5, delay: -.6, transform: 'translate(10px,0)'
				timeLineCompSvg2.from '#competence #bgProg .rightProg', .5, delay: -.6, transform: 'translate(-10px,0)'
				timeLineCompSvg2.staggerFrom '#competence #inProg .nb', .7, opacity: '0', 0.1, '-=0.5'

				timeLineComp = new TimelineMax
				timeLineComp.add [tweenComp1, tweenComp2]
						.add [timeLineCompSvg1, timeLineCompSvg2]	

				sceneComp = new ScrollScene offset: -100, duration: 800, triggerElement: '#competence'
					.setTween timeLineComp
					.addTo controller

				verifBig = true
		else 
			if verifBig
				verifBig = false
				controller.removeScene sceneComp

				$('#competence .floatLeft h2, #competence .floatRight h2').css opacity: '0'
				$('#competence .floatLeft span').css width: '0'
				$('#competence #progResp').css marginLeft: '230px'
				$('#competence .floatRight span').css marginLeft: '255px', width: '0'
				$('#competence .floatLeft svg').css marginLeft: '60px'
				$('#competence #prog').css marginLeft: '70px'

				timeLineCompRespSvg1 = new TimelineMax
				timeLineCompRespSvg1.from '#competence .floatLeft svg', 1.4, marginLeft: '-150'
				timeLineCompRespSvg1.to '#competence .floatLeft span', 1.4, delay: -1.4, width: '210'
				timeLineCompRespSvg1.to '#competence .floatLeft h2', 0.5, delay: -0.5, opacity: '1'

				sceneCompRespSvg1 = new ScrollScene duration: 300, triggerElement: '#competence'
					.setTween timeLineCompRespSvg1
					.addTo controller

				timeLineCompRespSvg2 = new TimelineMax
				timeLineCompRespSvg2.from '#competence #prog', 1.4, marginLeft: '-70'
				timeLineCompRespSvg2.to '#competence #progResp', 1.4, delay: -1.4,  marginLeft: '80'
				timeLineCompRespSvg2.to '#competence .floatRight span', 1.4, delay: -1.4,  marginLeft: '108', width: '285'
				timeLineCompRespSvg2.to '#competence .floatRight h2', 0.5, delay: -0.5, opacity: '1'

				sceneCompRespSvg2 = new ScrollScene duration: 300, triggerElement: '#competence .floatRight'
					.setTween timeLineCompRespSvg2
					.addTo controller
				verifSmall = true


#----Link
	$('a').click (e) ->
		e.preventDefault()

		if ($(@).attr('href') == '#about' && $(window).scrollTop() >= 0 && $(window).scrollTop() <= $('#about').position().top-100)
			y = ($('#citation').offset().top) + $('#citation').height() - 100

		else if ($(@).attr('href') == '#portfolio')
			y = ($('#portfolio').offset().top) - 80 - 50

		else
			y = $($(@).attr('href')).offset().top - 50

		TweenMax.to window, 1,
			scrollTo: 
				y: y,
			ease:Power2.easeOut

#----Hover

	$('.fleche').hover(
		-> selector = $($(@).find('.flecheIcn')); TweenMax.to selector, 0.5, y:20
		-> selector = $($(@).find('.flecheIcn')); TweenMax.to selector, 0.5, y:0
	)

	$('#portfolio .wrapper li .wrap').hover(
		-> TweenMax.to $($(@).find('.txt')), 0.4, marginTop: 0; TweenMax.to $($(@).find('.txt')), 0.3, delay: 0.15, opacity:1; TweenMax.to $($(@).find('.overflow')), 0.2, opacity:0.8; TweenMax.to $($(@).find('.img')), 0.2, 'filter' : 'blur(3px)',
		-> TweenMax.to $($(@).find('.txt')), 0.9, marginTop: '-100%'; TweenMax.to $($(@).find('.txt')), 0.6, opacity:0; TweenMax.to $($(@).find('.overflow')), 1, opacity:0; TweenMax.to $($(@).find('.img')), 1.5, 'filter' : 'blur(0px)'
	)

	$('#cv svg').hover(
		-> TweenMax.to $($(@).find('#eyeCv')), 0.5, opacity:0.9; TweenMax.to $($(@).find('#textCv')), 0.5, opacity:0
		-> TweenMax.to $($(@).find('#eyeCv')), 0.5, opacity:0; TweenMax.to $($(@).find('#textCv')), 0.5, opacity:0.75
	)

#----Portfolio

	###$('#portfolio .wrapper').isotope 
		itemSelector: 'li',
		layoutMode: 'packery'###

	$('#portfolio .wrapper li .wrap').click ->
		selector = $(this).parent().attr('id')
		index = selector.replace(/[a-zA-Z\s]{7}/, '')
		if projectOpen == true
			changeProject index
		else
			project index

	$('#projectView .right svg.big').click ->
		exitProject()

	$('#projectView .right svg.sml').click ->
		`var index`
		if Number(lastIndex) == 6
			index = 0
		else
			index = Number(lastIndex) + 1
		changeProject index

	$('#projectView .left svg.sml').click ->
		`var index`
		if Number(lastIndex) == 0
			index = 6
		else
			index = Number(lastIndex) - 1
		changeProject index

	projectOpen = false
	projectFirstOpen = true
	lastIndex = ''
	sceneProjectViewR = ''
	sceneProjectViewL = ''

	project = (index) ->
		projectOpen = true
		TweenMax.to '#portfolio .loader', .2, opacity: 1

		if projectFirstOpen == true
			TweenMax.to window, .2,
				scrollTo: y: $('#portfolio').offset().top - 50
				ease: Power2.easeOut

		projectFirstOpen = false
		$('#portfolio #projectView').css 'display', 'block'
		$('#projectView h2').html $('#portfolio #project' + index + ' .txt h2').html()
		$('#projectView p').html $('#portfolio #project' + index + ' .txt .desc').html()

		$.getJSON 'php/getProject.php?list=' + index, (data) ->
			lastIndex = index
			length = 0
			for item in data
				length = item
			i = 1
			while i <= length
				$('#projectView .wrap').append $('<img class=\'present\' />').attr('src', data[i])
				i++
				if i == length
					TweenMax.to '#portfolio .loader', .2, opacity: 0
					TweenMax.to '#projectView', .5,
						opacity: 1
						onComplete:
							callback = ->
								setTimeout (->
									callbackProjectTrigger()
									TweenMax.to '#projectViewNavLeft, #projectViewNavRight', .2, opacity: 1
								), 1000

	callbackProjectTrigger = ->
		durationTrigger = $('#projectView .wrap').height() - $('#projectView #projectViewNavLeft').height()
		sceneProjectViewR = new ScrollScene(
			duration: durationTrigger
			triggerElement: '#projectView').setPin('#projectViewNavRight', pushFollowers: true).addTo(controller)
		sceneProjectViewL = new ScrollScene(
			duration: durationTrigger
			triggerElement: '#projectView').setPin('#projectViewNavLeft', pushFollowers: true).addTo(controller)

	closeProject = ->
		projectOpen = false
		TweenMax.to window, .5,
			scrollTo: y: $('#portfolio').offset().top - 50
			ease: Power2.easeOut
			onComplete:
				callback = ->
					TweenMax.to '#projectView, #projectViewNavLeft, #projectViewNavRight', .5,
						opacity: 0
						onComplete:
							callback = ->
								$('#projectView img.present').remove()
								controller.removeScene [
									sceneProjectViewR
									sceneProjectViewL
								]
								sceneProjectViewR.destroy()
								sceneProjectViewL.destroy()
								controller.update true


	changeProject = (index) ->
		closeProject()
		setTimeout (->
			project index
		), 1000

	exitProject = ->
		closeProject()
		projectFirstOpen = true
		$('#portfolio .project').css 'display', 'none'

	resizeProject = ->
		if projectOpen == true
			controller.removeScene [
				sceneProjectViewR
				sceneProjectViewL
			]
			sceneProjectViewR.destroy()
			sceneProjectViewL.destroy()
			controller.update true
			setTimeout (->
				callbackProjectTrigger()
			), 100

	$(window).resize ->
		resizeProject()

#----CV

	$('#cv svg').click ->
		TweenMax.to $('#cv svg, #cv span'), 0.5,
			opacity: 0,
			onComplete:
				callback = ->
					$('#cv svg, #cv span').css 'display', 'none'
					$('#cv img, #cv .img').css 'display', 'block'
					$('#cv').css 'height', '100%'
					TweenMax.to $('#cv img'), 0.5, opacity: 1

	$('#cv img').click ->
		TweenMax.to $('#cv img'), 0.5,
			opacity: 0,
			onComplete:
				callback = ->
					$('#cv svg, #cv span').css 'display', 'block'
					$('#cv img, #cv .img').css 'display', 'none'
					$('#cv').css 'height', '800px'
					TweenMax.to $('#cv svg'), 0.5, opacity: 1
					TweenMax.to $('#cv span'), 0.5, opacity: 0.5

#----Formulaire

	verifCar = (champ) ->
		v = 0
		i = champ.length - 1

		while i >= 0
			testCar = champ.charAt(i)
			regex = /[a-zâäàéèùêëîïôöçñ\.?'!0-9\s_-]/i
			v++  unless regex.test(testCar)
			i--
		v

	$("#formulaire").on "submit", ->
		$this = $(this)
		nomVerif = $("#nom").val()
		mailVerif = $("#mail").val()
		raisonVerif = $("#raison").val()
		messageVerif = $("#message").val()
		checkNom = false
		checkMail = false
		checkRaison = false
		checkMessage = false
		check = false
		checkFalse = "red"
		checkTrue = "transparent"
		bg = "background-color"

		if nomVerif.length > 2 and nomVerif.length < 25
			n = verifCar(nomVerif)
			checkNom = true  if n is 0

		regex = /^[a-zA-Z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$/
		checkMail = true  if regex.test(mailVerif)

		r = verifCar(raisonVerif)
		checkRaison = true  if r is 0
		m = verifCar(messageVerif)
		checkMessage = true  if m is 0
		check = true  if checkNom and checkMail and checkRaison and checkMessage

		if nomVerif is "" or mailVerif is "" or raisonVerif is "" or messageVerif is ""
			$("#contact .error").animate
					opacity: 1
				, "slow"
			$("#contact .error").html "Les champs doivent êtres tous remplis"
			if nomVerif is ""
				$("#contact li:nth-child(1) input").css bg, checkFalse
			else
				$("#contact li:nth-child(1) input").css bg, checkTrue
			if mailVerif is ""
				$("#contact li:nth-child(2) input").css bg, checkFalse
			else
				$("#contact li:nth-child(2) input").css bg, checkTrue
			if raisonVerif is ""
				$("#contact li:nth-child(3) input").css bg, checkFalse
			else
				$("#contact li:nth-child(3) input").css bg, checkTrue
			if messageVerif is ""
				$("#contact li:nth-child(4) textarea").css bg, checkFalse
			else
				$("#contact li:nth-child(4) textarea").css bg, checkTrue

		else
			if check
				$("#contact li input").css bg, checkTrue
				$("#contact li textarea").css bg, checkTrue
				$("#contact .error").animate
					opacity: 0
					, "fast"
				$.ajax
					url: $this.attr("action")
					type: $this.attr("method")
					data: $this.serialize()
					success: ->
						$("#contact .error").animate
							opacity: 1
							, "slow"
						$("#contact .error").html "Email bien envoyer!"
						$("#nom").val ""
						$("#mail").val ""
						$("#raison").val ""
						$("#message").val ""
						setTimeout (->
							$("#contact .error").animate
								opacity: 0
								, "fast"
						), 3000
			else
				$("#contact .error").animate
					opacity: 1
					, "slow"
				if checkNom is false
					$("#contact li:nth-child(1) input").css bg, checkFalse
					$("#contact .error").html "Entrez uniquement des lettres, des chiffres, et les caractères standard d'ecriture ( . ! ' _- )"
				else
					$("#contact li:nth-child(1) input").css bg, checkTrue
				if checkMail is false
					$("#contact li:nth-child(2) input").css bg, checkFalse
					$("#contact .error").html "Placez une adresse valide sous la forme de xxx@xxx.com"
				else
					$("#contact li:nth-child(2) input").css bg, checkTrue
				if checkRaison is false
					$("#contact li:nth-child(3) input").css bg, checkFalse
					$("#contact .error").html "Entrez uniquement des lettres, des chiffres, et les caractères standard d'ecriture ( . ! ' _- )"
				else
					$("#contact li:nth-child(3) input").css bg, checkTrue
				if checkMessage is false
					$("#contact li textarea").css bg, checkFalse
					$("#contact .error").html "Entrez uniquement des lettres, des chiffres, et les caractères standard d'ecriture ( . ! ' _- )"
				else
					$("#contact li textarea").css bg, checkTrue
		false
