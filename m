From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: Kvaser leaf light
Date: Thu, 19 Mar 2015 11:31:52 -0400
Message-ID: <20150319153152.GA2121@linux>
References: <22529898.19.1426775220044.JavaMail.RPO@mac-rpo.local>
 <2201387.22.1426775565285.JavaMail.RPO@mac-rpo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38665 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbCSPb5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Mar 2015 11:31:57 -0400
Received: by wifj2 with SMTP id j2so72482917wif.1
        for <linux-can@vger.kernel.org>; Thu, 19 Mar 2015 08:31:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2201387.22.1426775565285.JavaMail.RPO@mac-rpo.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ralph Potztal <ralph.potztal@espros.com>
Cc: linux-can@vger.kernel.org

Hi Ralph,

On Thu, Mar 19, 2015 at 03:32:48PM +0100, Ralph Potztal wrote:
> 
> Hi there, 
> 
> I'm trying hard to setup the Kvaser Leaf Light HS v2 with SocketCan on a Ubuntu 14.04.2 workstation. Unfortunately I failed so far and therefor wanted to ask you, if you can give me some help.
> 
> My goal is to use the leaf together with wireshark to spy a can bus in one of our automated test systems.
> 
> How I'm trying to set it up:
> - loading kernel modules:
> # modprobe can
> # modprobe can_raw
> # modprobe can_bcm
> # modprobe kvaser_usb
> # modprobe vcan
> 
> - plug the leaf
> 
> - check if the leaf is there:
> # lsusb
> Bus 001 Device 002: ID 0bfd:0120 Kvaser AB
> 

Great, this USB device ID (288/0x120) is indeed supported by the
kvaser_usb module. It was added only in linux-3.16 though:

    https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b4f20130a

So, what is version of your kernel? A `uname -a' would be
quite helpful.

Thanks,
Darwish
