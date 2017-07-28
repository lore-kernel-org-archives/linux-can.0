From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: reading from socket can
Date: Fri, 28 Jul 2017 21:45:12 +0200
Message-ID: <20170728194512.GB10599@airbook.vandijck-laurijssen.be>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de>
 <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net>
 <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de>
 <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:59665 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbdG1Tqu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2017 15:46:50 -0400
Content-Disposition: inline
In-Reply-To: <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Michael Dressel <michael.dressel@desy.de>, linux-can@vger.kernel.org

> I was really unsure if
> 
> 	nread = read(can_fd, &rx[0], sizeof(struct can_frame) * 10);
> 
> makes sense at all - and nread would ever be greater than 1 ?!?

recvmmsg() is what you need to read up to 10 CAN frames at once.

Kurt
