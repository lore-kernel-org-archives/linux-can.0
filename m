From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Kvaser lapcan driver (init and probe)
Date: Sat, 21 Jun 2014 16:39:06 +0200
Message-ID: <53A5990A.5050409@hartkopp.net>
References: <CAGqyy=ZHGDovR1i_ZzKqTYqp5QAVhbSco6uwE2-nFefL-g+ouw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:13330 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbaFUOjM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Jun 2014 10:39:12 -0400
In-Reply-To: <CAGqyy=ZHGDovR1i_ZzKqTYqp5QAVhbSco6uwE2-nFefL-g+ouw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luis de Arquer <ldearquer@gmail.com>
Cc: linux-can@vger.kernel.org

Hello Luis,

in the Linux kernel there's a MAINTAINERS file and additionally
the get_maintainer.pl script shows up the maintainers:

user@host:~/linux$ scripts/get_maintainer.pl -f drivers/pcmcia
Bjorn Helgaas <bhelgaas@google.com> (commit_signer:5/13=38%)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:5/13=38%)
Yijing Wang <wangyijing@huawei.com> (commit_signer:2/13=15%,authored:2/13=15%)
"Rafael J. Wysocki" <rafael.j.wysocki@intel.com> (commit_signer:2/13=15%,authored:1/13=8%)
Rob Herring <rob.herring@calxeda.com> (commit_signer:2/13=15%,authored:2/13=15%)
Yinghai Lu <yinghai@kernel.org> (authored:2/13=15%)
Libo Chen <libo.chen@huawei.com> (authored:2/13=15%)
linux-pcmcia@lists.infradead.org (open list:PCMCIA SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

So you should post your driver on either linux-pcmcia@lists.infradead.org
and linux-can@vger.kernel.org.

I've done the EMS PCMCIA CAN driver due to the same reason (I had some of
them laying around at work). I would take a look into the PEAK/EMS_PCMCIA driver
and especially into the Softing driver from Kurt drivers/net/can/softing.

Try to send the patch with 'git send email' with proper "Signed-off-by:"
information. See:

linux/Documentation/SubmittingPatches

The patches should be based on linux-can/linux-can-next (on gitorious.org)
According the CAN stuff it should be in sync with
http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git
which is the next step in the upstream process.

Regards,
Oliver

