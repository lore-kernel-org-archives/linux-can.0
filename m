From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can-utils update for Debian
Date: Tue, 4 Feb 2020 17:59:14 +0100
Message-ID: <08b5fb48-bb69-0a34-3851-cb213d9b9f15@hartkopp.net>
References: <b6496d06-00ad-49e9-04bb-0062b19857dd@hartkopp.net>
 <20160925230257.68f3b937@brick.gerasiov.net>
 <ee55bc09-f60a-a637-e0d4-ff4aa69c9df1@hartkopp.net>
 <20160927110637.3d7f7ece@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:19921 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBDQ7Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2020 11:59:25 -0500
In-Reply-To: <20160927110637.3d7f7ece@brick.gerasiov.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Gerasiov <gq@debian.org>
Cc: linux-can <linux-can@vger.kernel.org>

Hello Alexander,

we have a new tag v2020.02.04 which is worth to make it a Debian package 
after nearly two years.

Relevant things that have changed:

- SPDX license compliance and cleanup
- new tools for CAN J1939 (since Linux 5.4)
- remove bridging functionality from candump

and of course several updates and enhancements.

We already had people that asked for an update of the tag to get an 
update on Debian ;-)

There is also another 2020.x tag - but the latest 2020.02.04 has a late 
fix for isotpsniffer.

Many thanks and best regards,
Oliver

ps. I remember your attempt to create man pages for the can-utils. We 
should probably plan this for the next but one release.
