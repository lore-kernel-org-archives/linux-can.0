From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: SocketCAN: Matlab/Simulink embedded coder support
Date: Wed, 15 Oct 2014 21:05:59 +0200
Message-ID: <CAGm1_ks9PdD8T7yarLrSE3Vugph=Hft1N+3HiH1=+OLATR9uaQ@mail.gmail.com>
References: <CAGm1_ktOSQwWgmoZFuBtn0+hJ4zWiEs7iukzEZoQJWNu+zeDHA@mail.gmail.com>
 <201405191606.15857.pisa@cmp.felk.cvut.cz> <CAGm1_ks89UjyXrXsO4MewvafDZuag1DwBrHspv+SENgvEoQe3g@mail.gmail.com>
 <201410152049.23487.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59769 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbaJOTGT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Oct 2014 15:06:19 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so1861662pad.1
        for <linux-can@vger.kernel.org>; Wed, 15 Oct 2014 12:06:19 -0700 (PDT)
In-Reply-To: <201410152049.23487.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Michal Sojka <sojkam1@fel.cvut.cz>

On Wed, Oct 15, 2014 at 8:49 PM, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
> Hello Yegor and others,
>
> I want to inform you that we have basic blocks working
> with SocketCAN already and we have demonstrated our
> setup to control and monitor small robotic arm over
> CANopen PDO messages at Real Time Linux Workshop
> at Dusseldorf last Sunday.
>
> https://www.osadl.org/?id=2018
>
> The minimalist information page can be found
> at our ERT Linux site pages
>
> http://lintarget.sourceforge.net/can_bus/index.html
>
> The initial support is limited to three CAN
> buses can0, can1 and can2 are mapped to CAN1,
> CAN2 and CAN3 selector. We need to find a little
> better generic way how to select bus list
> and network interface names yet.
> CAN receive and CAN transmit blocks can
> be connected directly to some simple signal
> types or Simulink predefined CAN_MESSAGE_TYPE together
> with CAN Pack and CAN Unpack can be used.
>
> The model has to include CAN setup block.
>
> We expect to prepare more complete announcement when
> we have time to polish the support a little more.
> But I believe that even in this preliminary state
> code can be usesfull and feedback is welcome.
> Be warned, API and blocks parameters can be changed
> before stable release.

Great news! Thanks!

Yegor
