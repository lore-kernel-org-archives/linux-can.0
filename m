From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 9 Aug 2012 10:39:52 +0800
Message-ID: <502322F8.8000806@gmail.com>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org> <1340853701-4488-3-git-send-email-shawn.guo@linaro.org> <502226AB.4050205@gmail.com> <5022377E.7000606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:40225 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab2HICke (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 Aug 2012 22:40:34 -0400
In-Reply-To: <5022377E.7000606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Marc Kleine-Budde wrote:
> adding linux-can on Cc.
>
> On 08/08/2012 10:43 AM, Hui Wang wrote:
>  =20
>> Hi Shawn,
>>
>> Any progress on this patch, has it been merged?
>>    =20
>
> No, for several reasons:
> - I don't want to have a "toggle transceiver gpio" function open code=
d
>   in every CAN driver. For now it's just flexcan, but on at91 we need
>   the same functionality.
> - The transceiver may be shared by several CAN cores, to sharing must
>   be designed in.
> - Lothar Wa=DFmann posted a more generic solution:
>   http://patchwork.ozlabs.org/patch/168023/
>
>  =20
Glad to know it, thanks.

Hui.
> Marc
>
>  =20

