init = ->
	document.getElementById('home').style.height = window.innerHeight + 'px';
init()

$ ->
	$(window).resize init

#----Menu
	responsiveMenuFtc = ->
		if window.innerWidth > 480
			$('header .responsiveMenu').css display: 'none', opacity: 1
			$('header li').css display: 'inline-block', opacity: 1

			$(window).on
				'scroll.Scrolling' : ->
					scrollTop = $(window).scrollTop()
					positionHome = $('#home').position().top-100
					positionAbout = $('#about').position().top-100
					positionCompetence = $('#competence').position().top-100
					positionPortfolio = $('#portfolio').position().top-100
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
		if window.innerWidth < 480
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
	timeLineCitationTop.fromTo '#citation .decoWrapperTop', 1.5, 
		rotation: '45', ease: Linear.easeNone,
			rotation: '0', ease: Linear.easeNone
	timeLineCitationTop.fromTo '#citation .decoWrapperTop', 0.7, 
		top: '50%', ease: Linear.easeNone,
			top: '0', ease: Linear.easeNone

	timeLineCitationBot = new TimelineMax
	timeLineCitationBot.fromTo '#citation .decoWrapperBottom', 1.5, 
		rotation: '-45', ease: Linear.easeNone,
			rotation: '0', ease: Linear.easeNone
	timeLineCitationBot.fromTo '#citation .decoWrapperBottom', 0.7, 
		top: '50%', ease: Linear.easeNone,
			top: '100%', ease: Linear.easeNone

	tweenCitationTxt = TweenMax.fromTo '#citation .wrapper p', 1,
	opacity: '0',
		opacity: '1'
	'-=0.4'

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
			'-=0.1'

	sceneAbout = new ScrollScene duration: 500, triggerElement: '#citation p'
		.setTween timeLineAbout
		.addTo controller
		#.addIndicators zindex: 50000, suffix: 'about'

	# Competance
	document.getElementById('competence').style.top = '-80px'
	if window.innerWidth > 1340
		$('#competence #prog, #competence .floatLeft svg').css marginLeft: '-100px'
		$('#competence .floatLeft h2, #competence .floatRight h2').css opacity: '1'

		timeLineCompSvg1 = new TimelineMax
		timeLineCompSvg1.from '#competence #bgGraph', 0.7, opacity: '0',  ease: Linear.easeNone
		timeLineCompSvg1.from '#competence #inGraph', 0.5, delay: -0.4, opacity: '0',  ease: Linear.easeNone
		timeLineCompSvg1.from '#competence #bgGraph', 0.8, delay: -0.6, rotation:"360", transformOrigin:"50% 50%"

		timeLineCompSvg2 = new TimelineMax
		timeLineCompSvg2.from '#competence #bgProg,#competence #inProg', 0.7, opacity: '0',  ease: Linear.easeNone
		timeLineCompSvg2.from '#competence #bgProg .leftProg', 0.7, delay: -0.6, transform: 'translate(10px,0)'
		timeLineCompSvg2.from '#competence #bgProg .rightProg', 0.7, delay: -0.6, transform: 'translate(-10px,0)'
		timeLineCompSvg2.staggerFrom '#competence #inProg .nb', 0.8, opacity: '0', 0.1

		tweenComp1 = TweenMax.from '#competence .floatLeft', 1, left: '-100%',  ease: Linear.easeNone
		tweenComp2 = TweenMax.from '#competence .floatRight', 1, right: '-100%',  ease: Linear.easeNone

		timeLineComp = new TimelineMax
		timeLineComp.add [tweenComp1, tweenComp2]
				.add [timeLineCompSvg1, timeLineCompSvg2]	

		sceneComp = new ScrollScene duration: 1000, triggerElement: '#about'
			.setTween timeLineComp
			.addTo controller

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

		# Competance Fix Anim
	$(window).resize ->
		if window.innerWidth > 1340
			if verifSmall
				verifSmall = false
				controller.removeScene [sceneCompRespSvg2, sceneCompRespSvg1]

				$('#competence #prog, #competence .floatLeft svg').css marginLeft: '-100px'
				$('#competence .floatLeft h2, #competence .floatRight h2').css opacity: '1'

				timeLineCompSvg1 = new TimelineMax
				timeLineCompSvg1.from '#competence #bgGraph', 0.7, opacity: '0',  ease: Linear.easeNone
				timeLineCompSvg1.from '#competence #inGraph', 0.5, delay: -0.4, opacity: '0',  ease: Linear.easeNone
				timeLineCompSvg1.from '#competence #bgGraph', 0.8, delay: -0.6, rotation:"360", transformOrigin:"50% 50%"

				timeLineCompSvg2 = new TimelineMax
				timeLineCompSvg2.from '#competence #bgProg,#competence #inProg', 0.7, opacity: '0',  ease: Linear.easeNone
				timeLineCompSvg2.from '#competence #bgProg .leftProg', 0.7, delay: -0.6, transform: 'translate(10px,0)'
				timeLineCompSvg2.from '#competence #bgProg .rightProg', 0.7, delay: -0.6, transform: 'translate(-10px,0)'
				timeLineCompSvg2.staggerFrom '#competence #inProg .nb', 0.8, opacity: '0', 0.1

				tweenComp1 = TweenMax.from '#competence .floatLeft', 1, left: '-100%',  ease: Linear.easeNone
				tweenComp2 = TweenMax.from '#competence .floatRight', 1, right: '-100%',  ease: Linear.easeNone

				timeLineComp = new TimelineMax
				timeLineComp.add [tweenComp1, tweenComp2]
						.add [timeLineCompSvg1, timeLineCompSvg2]	

				sceneComp = new ScrollScene duration: 1000, triggerElement: '#about'
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
					#.addIndicators zindex: 50000, suffix: 'competenceRespSVG1'

				timeLineCompRespSvg2 = new TimelineMax
				timeLineCompRespSvg2.from '#competence #prog', 1.4, marginLeft: '-70'
				timeLineCompRespSvg2.to '#competence #progResp', 1.4, delay: -1.4,  marginLeft: '80'
				timeLineCompRespSvg2.to '#competence .floatRight span', 1.4, delay: -1.4,  marginLeft: '108', width: '285'
				timeLineCompRespSvg2.to '#competence .floatRight h2', 0.5, delay: -0.5, opacity: '1'

				sceneCompRespSvg2 = new ScrollScene duration: 300, triggerElement: '#competence .floatRight'
					.setTween timeLineCompRespSvg2
					.addTo controller
					#.addIndicators zindex: 50000, suffix: 'competenceRespSVG2'
				verifSmall = true

#----Link

	$('header li a, #home .bottom').click (e) ->
		e.preventDefault()
		#--- if ($(@).attr('href'))  // Add contact fixed !
		TweenMax.to window, 1,
			scrollTo: 
				y: ($($(@).attr('href')).position().top-50),
			ease:Power2.easeOut

	$('#home .wrapper a').click (e) ->
		e.preventDefault()
		TweenMax.to window, 1,
			scrollTo:
				y: ($($(@).attr('href')).position().top)+($('#portfolio').position().top),
			ease:Power2.easeOut

#----Hover

	$('.fleche').hover(
		-> selector = $($(@).find('.flecheIcn')); TweenMax.to selector, 0.5, y:20
		-> selector = $($(@).find('.flecheIcn')); TweenMax.to selector, 0.5, y:0
	)

#----Portfolio

	$('#portfolio .wrapper').isotope 
		itemSelector: 'li',
		layoutMode: 'packery'

	initSvg = ->
	  speed = 250
	  easing = mina.easeinout
	  [].slice.call(document.querySelectorAll("#portfolio .wrapper a")).forEach (el) ->
	    s = Snap(el.querySelector("svg"))
	    path = s.select("path")
	    pathConfig =
	      from: path.attr("d")
	      to: el.getAttribute("data-path-hover")

	    el.addEventListener "mouseenter", ->
	      # console.log el + "  /////   " + s + "  /////   " + pathConfig
	      path.animate
	        path: pathConfig.to
	      , speed, easing
	      return

	    el.addEventListener "mouseleave", ->
	      path.animate
	        path: pathConfig.from
	      , speed, easing

	initSvg()

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
