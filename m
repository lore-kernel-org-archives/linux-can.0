From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] j1939: initial namespace support
Date: Fri, 16 Feb 2018 12:44:28 +0100
Message-ID: <20180216114428.y5hcujary2ystj3k@pengutronix.de>
References: <20180216073137.17509-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41215 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965215AbeBPLob (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 06:44:31 -0500
Content-Disposition: inline
In-Reply-To: <20180216073137.17509-1-o.rempel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ecathinds@gmail.com, linux-can@vger.kernel.org
Cc: Oleksij Rempel <linux@rempel-privat.de>

On Fri, Feb 16, 2018 at 08:31:37AM +0100, Oleksij Rempel wrote:
> From: Oleksij Rempel <linux@rempel-privat.de>
> 
> move all transport local variables to can_j1939 namespace
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  include/net/net_namespace.h   |   4 +
>  include/net/netns/can_j1939.h |  22 +++
>  net/can/j1939/address-claim.c |   8 +-
>  net/can/j1939/bus.c           |   8 +-
>  net/can/j1939/j1939-priv.h    |  14 +-
>  net/can/j1939/main.c          |  27 ++--
>  net/can/j1939/socket.c        |  12 +-
>  net/can/j1939/transport.c     | 320 ++++++++++++++++++++++--------------------
>  8 files changed, 232 insertions(+), 183 deletions(-)
>  create mode 100644 include/net/netns/can_j1939.h

Some comments about this patch. My mistake i needed to include it in to
the changelog.
This patch moves all per module/local variables, locks and workqueues in to a
name space. So, it should be configurable per interface, not per module.

Here is one example which I used as test case:
#create peer pars. vcan* will go in to name space. vxcan* will go
# in to root name space.
ip link add dev vcan0 type vxcan peer name vxcan0
ip link add dev vcan1 type vxcan peer name vxcan1

#add can gateway rules for routing between can0 and vxcan* peers.
cangw -A -s can0 -d vxcan0 -e
cangw -A -d can0 -s vxcan0 -e
cangw -A -s can0 -d vxcan1 -e
cangw -A -d can0 -s vxcan1 -e
# set this to allow communication between red and blue name spaces.
cangw -A -d vxcan0 -s vxcan1 -e
cangw -A -s vxcan0 -d vxcan1 -e

# create name spaces
ip netns add blue
ip netns add red

# move vcan*s to separate name spaces.
ip link set vcan0 netns blue
ip link set vcan1 netns red

# bring up vxcans in root name space.
ip link set up vxcan0
ip link set up vxcan1

# bring up interfaces in name spaces
ip netns exec blue ip link set up vcan0
ip netns exec red ip link set up vcan1

# start to capture on can0 and send from name spaces.
# this should work.
candump vcan0 &
ip netns exec blue testj1939 -s20 vcan0:0x80 :0x90,0x12300
ip netns exec red testj1939 -s20 vcan1:0x80 :0x90,0x12300

# if cangw not configured to pass packets between vxcan0 and vxcan1
# this should fail
ip netns exec blue candump vcan0 &
ip netns exec red testj1939 -s20 vcan1:0x80 :0x90,0x12300

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
