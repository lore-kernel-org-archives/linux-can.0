From: Michael Dressel <michael.dressel@desy.de>
Subject: Re: reading from socket can
Date: Sat, 29 Jul 2017 10:16:13 +0200 (CEST)
Message-ID: <alpine.LRH.2.20.1707291003380.19613@pal45.desy.de>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de> <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net> <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de> <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
 <20170728194512.GB10599@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-1.desy.de ([131.169.56.154]:35008 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753415AbdG2IQQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 29 Jul 2017 04:16:16 -0400
Received: from smtp-map-1.desy.de (smtp-map-1.desy.de [131.169.56.66])
        by smtp-o-1.desy.de (DESY-O-1) with ESMTP id EB8A32809FE
        for <linux-can@vger.kernel.org>; Sat, 29 Jul 2017 10:16:14 +0200 (CEST)
In-Reply-To: <20170728194512.GB10599@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi,

thanks for the information.

On Fri, 28 Jul 2017, Kurt Van Dijck wrote:

> recvmmsg() is what you need to read up to 10 CAN frames at once.

As stated in my previous message, I'm not sure what the authors aimed
for with that code.

My initial suspicion was that read() could even return with a number
of bytes that is not a multiple of can_frame size.

Cheers,
Michael
