From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: Socketcan correct way to bootup...
Date: Wed, 9 Jul 2014 14:29:45 +0200
Message-ID: <CAGm1_kuBTJEsTjrYCtop6vcdB+pyNe64bjVgMbz6F0bXsGsHeg@mail.gmail.com>
References: <53BD1BE1.8050403@eurekelettronica.it> <53BD248F.5030608@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:50940 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446AbaGIMaG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jul 2014 08:30:06 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so9101282pab.4
        for <linux-can@vger.kernel.org>; Wed, 09 Jul 2014 05:30:06 -0700 (PDT)
In-Reply-To: <53BD248F.5030608@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: gianluca <gianlucarenzi@eurekelettronica.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wed, Jul 9, 2014 at 1:16 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 07/09/2014 12:39 PM, gianluca wrote:
>> I was wondering if there is some "Offical" way to bring-up a socketcan
>> interface during bootup of a Linux System. Actually I write a simple
>> script BEFORE running my application in this way:
>
> Depends on your Distribution/init system.
>
>> # run.sh 125000 75 can0
>>
>> [ run.sh ]
>> #!/bin/sh
>> BITRATE=$1
>> SAMPLE=".$2"
>> INTERFACE=$3
>> ip link set $INTERFACE up type can bitrate ${BITRATE} sample-point
>> ${SAMPLE}
>> ip -details link show $INTERFACE
>> while [ true ];
>> do
>>     ./myapplication
>> done
>>
>> Are there some guidelines on how to approach this startup? i.e. I was
>> thinking about similar to ifup /etc/network/interface but with the
>> addendum of the bitrate and sample point...
>
> On recent Debian based Distris you can use ifup/ifdown for CAN
> interfaces. See the man page of interfaces.
>
> If you use busybox's ifup/ifdown you can fall back to the "inet manual"
> mode and specify /sbin/ip commands to configure and up/down your
> interface. On systemd you can add a service that starts CAN and runs
> before your actual program.
>
> Marc
>
> BTW: you probably want to integrate your application into the automatic
> startup via an init script or in new designs with systemd...and _not_
> start it by hand.

You can also use libsocketcan or libnl to configure CAN interface
directly from your application.

Yegor
