From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can-utils: install in /usr/bin instead of /usr/local/bin ??
Date: Thu, 23 Jan 2014 14:58:45 +0100
Message-ID: <52E12015.7000201@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.223]:9302 "EHLO
	mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbaAWN6y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 08:58:54 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

when can-utils are now intended to be packaged for Debian:

Does it make sense to move the installation directory to /usr/bin instead of
the current /usr/local/bin target??

Regards,
Oliver
