From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: LEDs: documentation
Date: Thu, 12 Mar 2015 15:00:16 +0100
Message-ID: <CAGm1_kuKuFaEyj-JicFfiX=qBjOeNLEzdrCQLLrXxE04OL=2Kw@mail.gmail.com>
References: <CAGm1_ktxocqFvQQ9Mrnk+ravrgpq-+RWw3vN0qsS=Qpa+o3WGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34447 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbbCLOAh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Mar 2015 10:00:37 -0400
Received: by pdno5 with SMTP id o5so20456688pdn.1
        for <linux-can@vger.kernel.org>; Thu, 12 Mar 2015 07:00:36 -0700 (PDT)
In-Reply-To: <CAGm1_ktxocqFvQQ9Mrnk+ravrgpq-+RWw3vN0qsS=Qpa+o3WGA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: fabio.baltieri@gmail.com

On Thu, Mar 12, 2015 at 10:21 AM, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> I have am335x based system and would like to use LED feature. Where
> can I find info about CAN LEDs subsystem? How can I configure LEDs via
> device tree?
>
> So far I couldn't find anything related under
> Documentation/devicetree/bindings/net/can/ or in
> Documentation/networking/can.txt.

So I got "can0-tx" running. But I have only one LED, that is called
"Data" and it just shows activity. It seems like one cannot combine
two triggers for one LED. Do I see it right? If yes, what about
creating another event called iface-rxtx or iface-activity like LEDs
in network interfaces?

What about errors? We have also "Error" LED. The main purpose is to
indicate "bus off" state.

Yegor
