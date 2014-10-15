From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: SocketCAN: Matlab/Simulink embedded coder support
Date: Wed, 15 Oct 2014 20:49:23 +0200
Message-ID: <201410152049.23487.pisa@cmp.felk.cvut.cz>
References: <CAGm1_ktOSQwWgmoZFuBtn0+hJ4zWiEs7iukzEZoQJWNu+zeDHA@mail.gmail.com> <201405191606.15857.pisa@cmp.felk.cvut.cz> <CAGm1_ks89UjyXrXsO4MewvafDZuag1DwBrHspv+SENgvEoQe3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:25143 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbaJOTYd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Oct 2014 15:24:33 -0400
In-Reply-To: <CAGm1_ks89UjyXrXsO4MewvafDZuag1DwBrHspv+SENgvEoQe3g@mail.gmail.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Michal Sojka <sojkam1@fel.cvut.cz>

Hello Yegor and others,

I want to inform you that we have basic blocks working
with SocketCAN already and we have demonstrated our
setup to control and monitor small robotic arm over
CANopen PDO messages at Real Time Linux Workshop
at Dusseldorf last Sunday.

https://www.osadl.org/?id=2018

The minimalist information page can be found
at our ERT Linux site pages

http://lintarget.sourceforge.net/can_bus/index.html

The initial support is limited to three CAN
buses can0, can1 and can2 are mapped to CAN1,
CAN2 and CAN3 selector. We need to find a little
better generic way how to select bus list
and network interface names yet.
CAN receive and CAN transmit blocks can
be connected directly to some simple signal
types or Simulink predefined CAN_MESSAGE_TYPE together
with CAN Pack and CAN Unpack can be used.

The model has to include CAN setup block.

We expect to prepare more complete announcement when
we have time to polish the support a little more.
But I believe that even in this preliminary state
code can be usesfull and feedback is welcome.
Be warned, API and blocks parameters can be changed
before stable release.

Best wishes,

                Pavel Pisa
                Department of Control Engineering
                at Czech technical University FEE
    e-mail:     pisa@cmp.felk.cvut.cz
    university: http://dce.fel.cvut.cz/
