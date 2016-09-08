From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [PATCH] CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation added.
Date: Thu, 8 Sep 2016 19:10:27 +0200
Message-ID: <201609081910.28236.pisa@cmp.felk.cvut.cz>
References: <1473145132-20895-1-git-send-email-deniz.eren@icloud.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:55080 "EHLO
        relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbcIHRoA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Sep 2016 13:44:00 -0400
In-Reply-To: <1473145132-20895-1-git-send-email-deniz.eren@icloud.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Deniz Eren <deniz.eren@icloud.com>, linux-can@vger.kernel.org
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, rizzo@iet.unipi.it, pbonzini@redhat.com

Hello Deniz,

thanks much for contribution and testing.

I have applied your patches to our QEMU
repo

  https://github.com/CTU-IIG/qemu

You find QEMU-2.6.1 based version of our merged
patches on "merged-2.6" branch.

I have updated and shortly tested all our topic branches
with actual QEMU-2.7.0 release. Simple test with
Linux within Linux and SocketCAN on both sides
works for PCI CAN-S (single SJA1000 channel) card
well with QEMU-2.7.0.

So I have undated all topics branches "can-pci",
"mf624" and "apohw" to this version then and created
"merged-2.7" branch. "merged" branch is now moved
to "merged-2.7" as well.

Your offer to help with mainlining is great as well.
Some discussion with somebody from core QEMU team
member is required.

I hope that actual CAN chip driver and PCI cards
follow QOM model right way. Problem is the simple
bus used for mesages delivery between CAN controllers.
These buses should be converted somehow to QOM acceptable
model. But for embedded development when you do not
freeze emulated system state is actual solution quite
usable as well.

It would be great to implement CAN FD (Flexible Datarate)
controller emulation support as well.

I am trying to find some diploma student for that for
two years already because he/she can have continuous
time for such work and testing which I cannot find.
Help from other instreested or project users would
be great as well.

Best wishes,

              Pavel




