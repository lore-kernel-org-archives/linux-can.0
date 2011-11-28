From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH net-next v2 2/4] can: cc770: add legacy ISA bus driver for the CC770 and AN82527
Date: Mon, 28 Nov 2011 14:03:27 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEE9@saturn3.aculab.com>
References: <4ED393B0.2030004@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <4ED393B0.2030004@grandegger.com>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, socketcan-users@lists.berlios.de, IreneV <boir1@yandex.ru>, Stanislav Yelenskiy <stanislavelensky@yahoo.com>
List-Id: linux-can.vger.kernel.org

 
...
> >> +	for (idx = 0; idx < MAXDEV; idx++) {
> > ARRAY_SIZE?
> 
> Well, I think ARRAY_SIZE is useful to derive the number of 
> elements from a static array of the type:
> 
>   static const int array[] = { 1, 2, 3, 4, }
> 
> but not if its declared as:
> 
>   static array[MAXDEV]:
> 
> ... or have I missed something?

Yes - if you use ARRAY_SIZE() then someone reading the code
doesn't need to find the array definition to ensure the loop
upper bound is correct.

	David
