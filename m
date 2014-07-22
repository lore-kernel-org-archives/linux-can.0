From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: Canutils can not up can0
Date: Tue, 22 Jul 2014 15:36:21 +0200
Message-ID: <CAGm1_ktkqP+9ONN_zX5vA+=s0-GeY4RwQ3iX-YGEt+rhjbgOKA@mail.gmail.com>
References: <53CE4BDC.1000508@gmail.com> <53CE4E59.90602@pengutronix.de>
 <53CE54BA.2070609@gmail.com> <53CE56F1.2070907@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:50704 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaGVNgm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jul 2014 09:36:42 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so11885635pad.21
        for <linux-can@vger.kernel.org>; Tue, 22 Jul 2014 06:36:41 -0700 (PDT)
In-Reply-To: <53CE56F1.2070907@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: grommerin <grommerin@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Tue, Jul 22, 2014 at 2:20 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Mikita,
>
> please keep the mailing list on Cc.
>
> On 07/22/2014 02:10 PM, grommerin wrote:
>> Now I try using this version:
>> https://gitorious.org/linux-can/can-utils/source/518faef3acc79bb4f31ae2b55b266eb540850f39:
>
> There is no canconfig in the gitoruous can-utils.
>
>> Working version: git://git.pengutronix.de/git/tools/canutils.git
>> No error messages. The problem is that I can not configure can0 and set
>> bitrate.
>> I can not attach a message "dmesg". "ifconfig" sees can0 but it is not
>> configured.
>
> Which canconfig are you using?

Please take a look at our turorial
http://elinux.org/Bringing_CAN_interface_up too.

Yegor
