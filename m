From: John Whitmore <arigead@gmail.com>
Subject: baudrate detection
Date: Thu, 12 Dec 2013 18:40:13 +0000
Message-ID: <20131212184012.GA18112@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:55996 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab3LLSkf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Dec 2013 13:40:35 -0500
Received: by mail-wi0-f177.google.com with SMTP id cc10so2953056wib.16
        for <linux-can@vger.kernel.org>; Thu, 12 Dec 2013 10:40:34 -0800 (PST)
Received: from griso.site ([93.107.69.95])
        by mx.google.com with ESMTPSA id n6sm27373486wix.3.2013.12.12.10.40.32
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2013 10:40:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi linux-can,

I'm coming from the embedded micro controller end of using CAN and have created
my own CAN Network nodes. Now I'm working with a MCP2515 connected to the
Raspberry Pi, so looking at the Linux Kernel.

On my existing nodes the Initialisation of the CAN device the node either knows
the baudrate to setup or it does not. A node that is a fixed node on the
network knows the baudrate of the network, although this can be changed on the
fly. Other devices are not a fixed part of the network and are connected
dynamically to the network for testing or management purposes. These nodes
don't know the baudrate of the network so automatically detect it. When they
detect the baudrate they then connect and inform the higher application code
that the network is connected, so they can proceed.

I was thinking of adding this auto baudrate detection functionality to the
RaspberryPi but being new to Linux development I'm struggling with whether
this functionality should be in Kernel or User Space. I was initially thinking
User Space but given that numerous applications can be using the CAN Network
you really want to centralise this functionality. That possibly means Kernel
Space?

So before I start to do something I thought I'd ask the experts. Does
automatic baudrate detection belong in Kernel Space or out in Userland? Maybe
it's already in the existing Kernel I've just missed it.

JW
