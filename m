From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] ip: add vxcan/veth to ip-link man page
Date: Sat, 16 Dec 2017 10:08:44 -0800
Message-ID: <20171216100844.4a8ff73f@xeon-e3>
References: <20171216113857.2397-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:42314 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbdLPSIq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 16 Dec 2017 13:08:46 -0500
Received: by mail-pg0-f53.google.com with SMTP id e14so7573936pgr.9
        for <linux-can@vger.kernel.org>; Sat, 16 Dec 2017 10:08:46 -0800 (PST)
In-Reply-To: <20171216113857.2397-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org

On Sat, 16 Dec 2017 12:38:57 +0100
Oliver Hartkopp <socketcan@hartkopp.net> wrote:

> veth and vxcan both create a vitual tunnel between a pair of virtual network
> devices. This patch adds the content for the now supported vxcan netdevices
> and the documentation to create peer devices for vxcan and veth.
> 
> Additional remove 'can' that accidently was on the list of link types which
> can be created by 'ip link add' as 'can' devices are real network devices.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied. Thanks for the doing this.
