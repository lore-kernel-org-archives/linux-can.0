From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v5 1/2] can: sja1000: fix "irq X: nobody cared" problem
Date: Sun, 24 Nov 2013 22:44:59 +0100
Message-ID: <1385329501-28021-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45015 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab3KXVpO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 16:45:14 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, kurt.van.dijck@eia.be

Hello,

as Kurt suggested I've split up the patch into two parts. I've added/keept
Wolfgang's Acks at both parts, hope that's okay. Further I've added to the
description of the first patch, that it fixes the "irq X: nobody cared". Is
this corrrect? If I understand the discussion and code correct, the second
patch is only relevant in the hot unplug case.

Who is the original reporter of that problem? I've added Wolfgang, as Oliver
did in his v1,v2 and v3 patch.

Marc


