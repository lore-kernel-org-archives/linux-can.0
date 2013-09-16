From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] slcand: add slcan_attach and UART settings
Date: Mon, 16 Sep 2013 09:14:20 +0200
Message-ID: <5236AFCC.1090909@hartkopp.net>
References: <1379067102-27741-1-git-send-email-yegorslists@googlemail.com> <5232F733.2040707@i2se.com> <5236147D.8020200@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:52503 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab3IPHO1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Sep 2013 03:14:27 -0400
In-Reply-To: <5236147D.8020200@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>, yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

On 15.09.2013 22:11, Oliver Hartkopp wrote:

> There's still one warning left:
> 
> slcand.c: In function 'daemonize':
> slcand.c:180:8: warning: variable 'dummyFile' set but not used [-Wunused-but-set-variable]
>   FILE *dummyFile;
>         ^
> 

Fixed :-)

BR,
Oliver

