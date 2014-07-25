From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4/5] net: can: flexcan: wait for completion when entering
 freeze mode
Date: Fri, 25 Jul 2014 20:50:15 +0200
Message-ID: <20140725185015.GA24839@linutronix.de>
References: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
 <1406312202-2542-4-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59207 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbaGYSuT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 14:50:19 -0400
Content-Disposition: inline
In-Reply-To: <1406312202-2542-4-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de

* Matthias Klein | 2014-07-25 20:16:41 [+0200]:

>After requesting Freeze Mode, the user must wait for the FRZ_ACK
>bit to be asserted in MCR before executing any other action,
>otherwise FLEXCAN may operate in an unpredictable way.

NAK on 4 + 5. A replacement is comming.

Sebastian
