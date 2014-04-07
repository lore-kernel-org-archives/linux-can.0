From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 07 Apr 2014 18:27:10 +0200
Message-ID: <5342D1DE.6070107@grandegger.com>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <1589068.2zsYHU9sGb@ws-stein> <alpine.DEB.2.02.1404071659360.14882@ionos.tec.linutronix.de> <10077840.fz9L5lnEL0@ws-stein> <alpine.DEB.2.02.1404071743270.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50913 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbaDGQ1N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 12:27:13 -0400
In-Reply-To: <alpine.DEB.2.02.1404071743270.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 04/07/2014 05:53 PM, Thomas Gleixner wrote:
> On Mon, 7 Apr 2014, Alexander Stein wrote:
>> On Monday 07 April 2014 17:24:26, Thomas Gleixner wrote:
>>> It'd be odd, because we get the buffers with the NEWDAT pending bits
>>> from the NEWDATA1 register.
>>
>  
>> Using the following patch the warning raises about every 5ms. With
>> and without your last patchset.
> 
>> but reverting c0a9f4d39 this does _NOT_ arise.
> 
> So the NEWDAT register is telling us that the newdat bit of that
> buffer is set. But when we retrieve the message, it's not set.


Not sure if it matters. There was a strange write-readback problem
reported with the PCH CAN. I digged out:

http://marc.info/?l=linux-can&m=135525750319741&w=2
http://marc.info/?l=linux-can&m=135525729919672&w=2
http://marc.info/?t=135296394900001&r=1&w=2

It got worse with concurrent activity of I2C on some eg20t system which
smells of a weired hardware problem (and could maybe explain the 5ms
period).

Wolfgang.


