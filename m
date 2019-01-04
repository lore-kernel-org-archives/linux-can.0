From: Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Fri, 4 Jan 2019 10:01:43 +0100
Message-ID: <20190104090143.GD28932@unicorn.suse.cz>
References: <20190103122634.2530-1-socketcan@hartkopp.net>
 <20190103140121.GB28932@unicorn.suse.cz>
 <9e4dfe7c-42cc-3dba-763a-23ce4e10389b@hartkopp.net>
 <20190103203347.GC28932@unicorn.suse.cz>
 <715d1d82-af65-9344-dcce-0ddcace50274@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <715d1d82-af65-9344-dcce-0ddcace50274@hartkopp.net>
Sender: stable-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, ieatmuttonchuan@gmail.com, meissner@suse.de, linux-can@vger.kernel.org, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Thu, Jan 03, 2019 at 10:03:47PM +0100, Oliver Hartkopp wrote:
> 1. I'm still using the test "if (cf->can_dlc > 8)" with a proper comment as
> CAN_MAX_DLC and CAN_MAX_DLEN are not defined in Linux stable 3.2 - so that
> we can apply the patch to all versions of gw.c

I may be biased as substantial part of my work consists of trying to
understand unfamiliar code written by other people but I believe
readability of the code is more important than avoiding a bit of work
with backport to older stable branches.

Michal Kubecek
