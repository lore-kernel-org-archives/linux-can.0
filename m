From: Austin Schuh <austin@peloton-tech.com>
Subject: Bus off
Date: Thu, 26 Jun 2014 10:13:17 -0700
Message-ID: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:54349 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756633AbaFZRNj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Jun 2014 13:13:39 -0400
Received: by mail-ig0-f173.google.com with SMTP id uq10so972372igb.12
        for <linux-can@vger.kernel.org>; Thu, 26 Jun 2014 10:13:38 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Does anyone know if the TX queues are cleared on BUS-OFF?

I have a machine connected to a network where all the other CAN nodes
shut off periodically.  I monitor whether or not they are sending, and
don't send messages unless I think they are on.  Right after they shut
off, I occasionally send out a message when they are off, which
triggers a bus-off.  I'm seeing lots of bus-off/restarts due to
restart-ms=1000 after the nodes shut down, and I'm pretty certain that
I'm not sending anything at that time.  Any ideas on what is going on
would be appreciated.

Thanks,
    Austin
