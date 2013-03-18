From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: j1939 - mainline problems
Date: Mon, 18 Mar 2013 22:31:25 +0100
Message-ID: <514787AD.50303@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:61636 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab3CRVb2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Mar 2013 17:31:28 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Kurt,

i still try to get behind the implementation.

Simplicity is something else ...

Some things that definitely will not go into mainline:

  7 can-j1939 SYSCTL
    7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
    7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
    7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms

sysfs for this kind of configuration is not getting into mainline.

Provide proper defaults and a sockopt interface, if people really want to
change their private defaults.

  6 can-j1939 procfs interface
    6.1 /proc/net/can-j1939/ecu
    6.2 /proc/net/can-j1939/filter
    6.3 /proc/net/can-j1939/sock
    6.4 /proc/net/can-j1939/transport

What does transport mean?
Does this entry appear when a PDU is sent and disappear afterwards?

-> seq_printf(sqf, "iface\tsrc\tdst\tpgn\tdone/total\n");

Supposed debugging output has to be removed anyway.

Things that look fishy:

#1 (Documentation)

  Per default j1939 is not active. Specifying can_ifindex != 0 in bind(2)
  or connect(2) needs an active j1939 on that interface. You must have done
  $ ip link set canX j1939 on
  on that interface.

Eh?

Never seen something like "ip link set eth0 tcp on" before setting the ip
address ??

Why doesn't it 'just work' ?

#2 (Documentation)

  Add the address to the system:
  $ ip addr add j1939 0x20 dev can0

  Bind:
    struct sockaddr_can addr;

    memset(&addr, 0, sizeof(addr));
    addr.can_ifindex = ifindex("can0"); // ifindex is a substitute.
    addr.can_addr.j1939.name = J1939_NO_NAME;
    addr.can_addr.j1939.addr = 0x20;
    addr.can_addr.j1939.pgn = J1939_NO_PGN;

    bind(sk, (void *)&addr, sizeof(addr));

Why does bind() not make the "ip addr add j1939 0x20 dev can0" automatically?

#3 (j1939/main.c)

in static void j1939_can_recv(struct sk_buff *skb, void *data)

        msg = (void *)skb->data;
        orig_len = skb->len;
        skb_pull(skb, CAN_HDR);
        /* fix length, set to dlc, with 8 maximum */
        skb_trim(skb, min_t(uint8_t, msg->can_dlc, 8));

You can not fiddle with skb offsets unless you've cloned it.

#4 (segments / ecus / bus / sk / ...)

Even when trying to follow any concepts in the source code, it's hard to
follow any idea when these structures and definitions are not described.

E.g. why don't you add a j1939_priv pointer to struct dev_rcv_lists when
CONFIG_CAN_J1939 is enabled?

Looks like j1939_segment_find() is a frequently used walkthrough function ...

#5 (j1939/main.c) filters

#define J1939_CAN_ID    CAN_EFF_FLAG
#define J1939_CAN_MASK  (CAN_EFF_FLAG | CAN_RTR_FLAG)

        ret = can_rx_register(netdev, J1939_CAN_ID, J1939_CAN_MASK,
                        j1939_can_recv, jseg, "j1939");

You read EVERY EFF frame. Filters should be created based on the concrete
requirement of the userspace (socket).

#6 (amount of code)

ls *.c | grep -v mod | xargs wc -l
   227 address-claim.c
   523 bus.c
    76 filter.c
   458 main.c
   104 proc.c
    43 promisc.c
   306 rtnl.c
   984 socket.c
  1449 transport.c
  4170 total

Sometimes i feel a much more simple approach is needed.

You provide a full featured 4 tons SUV IMO no one understands.
- thousands of knobs to configure
- and when looking under the hood you get lost from all the cables

I would like to have a bicycle and probably a quad with AC some days later.

E.g. with a struct j1939 message having an address field (similar to the
CAN-ID) with some data behind it.

That's simple and similar to other implementations.

I might be wrong with this requirement of simplicity.
But i might be right too.

Let's wait for beta-testers feedback if your concept is easy to use and adopt
for j1939 application programmers ...

Best regards,
Oliver
