From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [Socketcan-users] [PATCH net-next v2 1/4] can: cc770: add driver core for the Bosch CC770 and Intel AN82527
Date: Mon, 28 Nov 2011 14:01:41 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEE8@saturn3.aculab.com>
References: <4ED3941D.3070302@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:40833 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981Ab1K1ODk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Nov 2011 09:03:40 -0500
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 12678-10 for <linux-can@vger.kernel.org>;
 Mon, 28 Nov 2011 14:03:37 +0000 (GMT)
Content-class: urn:content-classes:message
In-Reply-To: <4ED3941D.3070302@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: netdev@vger.kernel.org, socketcan-users@lists.berlios.de, linux-can@vger.kernel.org

 
> >   enum {
> > 	CC770_OBJ_RX0 = 0,	/* for receiving normal messages */
> > 	CC770_OBJ_RX1,		/* for receiving normal messages */
> > 	CC770_OBJ_RX_RTR0,	/* for receiving remote transmission
requests */
> > 	CC770_OBJ_RX_RTR1,	/* for receiving remote transmission
requests */
> > 	CC770_OBJ_TX,		/* for sending messages */
> > 	CC770_OBJ_MAX  <================
> 
> ...then add a "," here :P

Not if the code might have to go through the C++ compiler.
C++ doesn't allow a trailing , in enums (some compilers
will error this....).

	David


