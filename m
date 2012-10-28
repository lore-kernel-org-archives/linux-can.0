From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] candump: add option to ignore ENOBUFS
Date: Sun, 28 Oct 2012 21:02:27 +0100
Message-ID: <508D8F53.1050005@hartkopp.net>
References: <1351244569-11398-1-git-send-email-yegorslists@googlemail.com> <508A5C05.6050803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:56545 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab2J1TCb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 28 Oct 2012 15:02:31 -0400
In-Reply-To: <508A5C05.6050803@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: yegorslists@googlemail.com, linux-can@vger.kernel.org

On 26.10.2012 11:46, Marc Kleine-Budde wrote:

> On 10/26/2012 11:42 AM, yegorslists@googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> -f option replicated -i option from cangen and allows to
>> ignore ENOBUFS error in bridge mode
> 
> Better not ignore, but handle the error. If socket would support, wait
> with select/poll that the socket get writable and try again. For now
> sleep and try again. (or fix the poll/select bug in the kernel).


ACK.

IIRC this was a problem of socket write queue length that are too long to
handle short MTUs like we have with CAN frames.
Therefore the socket itself does not stop the traffic.

Definitely something to be fixed ... i'll take a look into the mails from
Michal Sojka.

Regards,
Oliver


