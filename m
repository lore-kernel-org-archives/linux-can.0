From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v5 1/2] can: sja1000: fix "irq X: nobody cared" problem
Date: Mon, 25 Nov 2013 08:57:17 +0100
Message-ID: <808341cbce15240bc45f49ba76ae168b@grandegger.com>
References: <1385329501-28021-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:47813 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab3KYH5S (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 25 Nov 2013 02:57:18 -0500
In-Reply-To: <1385329501-28021-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, kurt.van.dijck@eia.be

Hi Marc,



On Sun, 24 Nov 2013 22:44:59 +0100, Marc Kleine-Budde <mkl@pengutronix.de>

wrote:

> Hello,

> 

> as Kurt suggested I've split up the patch into two parts. I've

added/keept

> Wolfgang's Acks at both parts, hope that's okay. Further I've added to

the

> description of the first patch, that it fixes the "irq X: nobody cared".

Is

> this corrrect? If I understand the discussion and code correct, the

second

> patch is only relevant in the hot unplug case.



It was Austin Schuh who reported a problem with -rt, which do not show up

with

vanilla Linux. See thread with the subject "sja1000 interrupt problem".

It's

still unclear what the real cause of this problem is. Anyway, Oliver and

myself

looked into the SJA1000 code and realized some inconsistencies with the

interrupt acknowledgement via "post_irq" callback. Oliver already

clarified

that.



Wolfgang.
