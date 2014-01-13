From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] candump: add option to ignore ENOBUFS
Date: Mon, 13 Jan 2014 19:15:11 +0100
Message-ID: <52D42D2F.3090405@hartkopp.net>
References: <1351244569-11398-1-git-send-email-yegorslists@googlemail.com> <508A5C05.6050803@pengutronix.de> <508D8F53.1050005@hartkopp.net> <52D06DE7.3010002@hartkopp.net> <CAGm1_kt4Vu3wrhOivOhO3zTbT3z3Q1HjHU5XmzZmdVjUGd1_Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:52904 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaAMSPO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 13:15:14 -0500
In-Reply-To: <CAGm1_kt4Vu3wrhOivOhO3zTbT3z3Q1HjHU5XmzZmdVjUGd1_Fg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Michal Sojka <sojkam1@fel.cvut.cz>

On 13.01.2014 11:00, Yegor Yefremov wrote:
> On Fri, Jan 10, 2014 at 11:02 PM, Oliver Hartkopp
> <socketcan@hartkopp.net> wrote:
>> Hi Yegor,
>>
>> the question about a blocking write was still not addressed :-(
> 
> Is this something to change in the generic networking stack or just
> SocketCAN core?

AFAICR it has something to do with socket buffer sizes and the poll function
which has to be implemented in CAN_RAW.

> I'm trying to add network functionality to slcanpty,c Reading from
> socket or pty doesn't make a big difference. But as soon as you try to
> send a lot of frames, you get ENOBUFS at once. I'm trying to
> understand, what is the best way to handle this situation. In cangen
> the situation is rather trivial, as one just sends. In slcanpty it
> should support simultaneous read/write, so I'll have to store unsent
> CAN frames somewhere, return to select handling and handle read stuff,
> before retrying send.

When you use a blocking write this may also slow down the original ASCII
source. You should probably think of two separate threads for rx/tx.

Regards,
Oliver

