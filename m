From: Timothy Vieregge <tvieregge@clearpathrobotics.com>
Subject: Re: Kernel Oops when setting j1939 device on
Date: Tue, 20 May 2014 16:46:10 -0400
Message-ID: <CAJdBzeBEL=pz4imZvywVwZsjj3o7Gh6JshgKrm3aSbYOjMiZ6Q@mail.gmail.com>
References: <CAJdBzeATNb2pBOdp5bpx86Bw+K00wYwjgFOuRGbtZSPXvMoBuQ@mail.gmail.com>
	<20140520201654.GD25701@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:59350 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbaETUqL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 May 2014 16:46:11 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so5375971igb.8
        for <linux-can@vger.kernel.org>; Tue, 20 May 2014 13:46:11 -0700 (PDT)
In-Reply-To: <20140520201654.GD25701@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Timothy Vieregge <tvieregge@clearpathrobotics.com>, linux-can@vger.kernel.org

I compiled the j1939-v3.8 branch into the kernel.
Also, I'm using the j1939-v3.6 branch of iproute2-j1939.

I didn't specifically replace any of the modules, I simply loaded the
ones that were present in the custom kernel (can, vcan and can_raw).
Although I assume that those were changed during the compilation.

Let me know if you want any more of my system info. The behaviour was
reproducible in a clean VM
