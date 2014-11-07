From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: candump error flags
Date: Fri, 07 Nov 2014 15:56:19 +0100
Message-ID: <545CDD93.1080600@hartkopp.net>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com> <545CD775.1030200@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:47869 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbaKGO4c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Nov 2014 09:56:32 -0500
In-Reply-To: <545CD775.1030200@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Paul Lever <svjeorgia@gmail.com>, linux-can@vger.kernel.org

On 07.11.2014 15:30, Marc Kleine-Budde wrote:
> On 11/07/2014 02:57 PM, Paul Lever wrote:
>> I'm trying to use the candump -e and -d options to catch errors. I
>> know that frames are being dropped, as I can see missing packets in
>> known sequences, yet I never see anything printed from candump
>> indicating any errors or dropped packets. Is there additional steps
>> needed to get output from -e/-d options? This is on a Beaglebone Black
>> platform.
>> My cmd line is:
>> candump -t a -e -d -r 16000 can0 > /media/testdata.raw&
>
> Make sure you're running a recent new kernel (v3.15 or better) as a lot
> of fixes went into the driver.
>

E.g. the dropcount functionality emerged in Linux 2.6.33
So a Debian Squeeze with 2.6.32 won't make it here ...

Regards,
Oliver

ps. additionally "candump -r 16000 -l can0 &" would be better :-)
