From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: MOVED TO GITHUB: Linux-CAN user space source repositories
Date: Thu, 05 Mar 2015 20:06:27 +0100
Message-ID: <54F8A933.1040309@hartkopp.net>
References: <CAGm1_ksdokuRQ8kAfX+EsjYAzZj3UXn5XH2duS2TMX_NjaYnUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:15237 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589AbbCETGe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Mar 2015 14:06:34 -0500
Received: from [192.168.1.194] (p5B0B1A58.dip0.t-ipconnect.de [91.11.26.88])
	by smtp.strato.de (RZmta 37.3 DYNA|AUTH)
	with ESMTPSA id w03fe0r25J6WN0X
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <linux-can@vger.kernel.org>;
	Thu, 5 Mar 2015 20:06:32 +0100 (CET)
In-Reply-To: <CAGm1_ksdokuRQ8kAfX+EsjYAzZj3UXn5XH2duS2TMX_NjaYnUg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

As Gitorious is to be acquired by GitLab and gitorious.org will shut down at 
end of May the Linux-CAN / SocketCAN git repositories have to be moved away 
from https://gitorious.org/linux-can/

As many of you already have a GitHub account Marc and I agreed on following 
Yegors suggestion to move the Linux-CAN / SocketCAN repos to GitHub.

You can now find the Linux-CAN repositories at:

	https://github.com/linux-can/

The repositories are moved & rearranged from gitorious.org as shown below:

	Linux-CAN / SocketCAN user space applications
	https://github.com/linux-can/can-utils/

	Linux-CAN / SocketCAN testing applications
	https://github.com/linux-can/can-tests/

	Firmware for supported CAN adapters
	https://github.com/linux-can/can-firmware/

	Linux-CAN / SocketCAN logos
	https://github.com/linux-can/can-logos/

	Linux-CAN / SocketCAN miscellaneous stuff
	https://github.com/linux-can/can-misc/

The can-modules repository was not moved as this network layer stuff mostly 
puzzled people who built the sources without success on recent systems. As 
most of the network layer CAN protocols are already in Linux mainline, I moved 
can-modules to a 'private' repository to continue my ISO 15765-2:2015 protocol 
development:

Obsolete CAN network layer modules *ONLY* used for ISO 15765-2 development now
https://github.com/hartkopp/can-isotp-modules/

This repo will stay there but it is now separated from user space resources.

If you have forked repos or other code on gitorious which relies on the former 
repository setup make sure not to lose your work when gitorious shuts down in 
May. From now on the development will only continue on GitHub.

Have fun!

Oliver

On 03.03.2015 22:35, Yegor Yefremov wrote:
> Does it effect us? Should can-utils move to github?
>
> http://lwn.net/Articles/635358/rss
>
> Yegor

