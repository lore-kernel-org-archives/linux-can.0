From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [BULK]Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong
 assumption in raw_rcv
Date: Mon, 06 Jul 2015 19:14:20 +0200
Message-ID: <559AB76C.5020608@hartkopp.net>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net> <558BBC92.6040906@peak-system.com> <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store> <55916EBC.2010807@hartkopp.net> <55980FCE.4030304@hartkopp.net> <559A3516.7080404@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:28014 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbbGFROb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Jul 2015 13:14:31 -0400
In-Reply-To: <559A3516.7080404@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, tom_usenet@optusnet.com.au, Manfred Schlaegl <manfred.schlaegl@gmx.at>

On 06.07.2015 09:58, Stephane Grosjean wrote:

> ${CUSTOMER}'s problem was rather a "loss of frame" issue than an
> "out-of-order" issue... In fact, it seems it was a simple "rookie" error of
> non-testing errno == ENOBUF after having written on the CAN socket.

Thanks for the explanation!

No more sleepless nights :-)

Regards,
Oliver
