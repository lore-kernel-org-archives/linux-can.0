From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Subject: Re: [PATCH] can: flexcan: add PM support
Date: Tue, 8 May 2012 17:30:01 +0200
Message-ID: <20120508173001.31ce8f0c@eb-e6520>
References: <1336489937-29645-1-git-send-email-eric@eukrea.com>
	<4FA9394A.90303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:51080 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755568Ab2EHPaK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 May 2012 11:30:10 -0400
In-Reply-To: <4FA9394A.90303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi Marc,

Le Tue, 08 May 2012 17:18:34 +0200,
Marc Kleine-Budde <mkl@pengutronix.de> a =E9crit :

> On 05/08/2012 05:12 PM, Eric B=E9nard wrote:
> > tested on an i.MX257
>=20
> What about the transceiver? Does is make sense to switch it off, too?
>=20
this could make sense on platform which have a transceiver with an
enable input. I can add flexcan_transceiver_switch after/before
flexcan_chip_disable/enable but won't be able to test that feature.

Eric
