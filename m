From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: j1939 - mainline problems
Date: Wed, 20 Mar 2013 11:18:35 +0100
Message-ID: <20130320101835.GB420@vandijck-laurijssen.be>
References: <514787AD.50303@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:29123 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751667Ab3CTKSm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Mar 2013 06:18:42 -0400
Content-Disposition: inline
In-Reply-To: <514787AD.50303@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, Mar 18, 2013 at 10:31:25PM +0100, Oliver Hartkopp wrote:
> Hi Kurt,
> 
> i still try to get behind the implementation.
> 
> Simplicity is something else ...

Do you mean the code or the j1939 protocol :-) ?

> 
> Some things that definitely will not go into mainline:
> 
>   7 can-j1939 SYSCTL
>     7.1 /proc/sys/net/can-j1939/transport_max_payload_in_bytes
>     7.2 /proc/sys/net/can-j1939/transport_cts_nr_of_frames
>     7.3 /proc/sys/net/can-j1939/transport_tx_retry_ms
> 
> sysfs for this kind of configuration is not getting into mainline.
s/sysfs/sysctl/ ?

Where to put tunables else than sysctl?
I tread /proc/sys/net/can-j1939/transport_tx_retry_ms
on the same level as /proc/sys/net/ipv4/tcp_keepalive_intvl and such.

> 
> Provide proper defaults and a sockopt interface, if people really want to
> change their private defaults.
These are not socket specific!
I could turn them into link specifics and use
	$ ip link set can0 j1939 transport-max-payload-in-bytes xxx
What about that?
it would put more effort in iproute2, and not decrease code size in kernel either.

> 
>   6 can-j1939 procfs interface
>     6.1 /proc/net/can-j1939/ecu
>     6.2 /proc/net/can-j1939/filter
>     6.3 /proc/net/can-j1939/sock
>     6.4 /proc/net/can-j1939/transport
> 
> What does transport mean?
> Does this entry appear when a PDU is sent and disappear afterwards?
Nope,
transport lists the pending transport sessions.
This is not debug, I have a specific use case for this:

Imagine a bigger transport protocol session, of about 500KB.
This takes (a lot of) time. A socket (like a gui application)
has no way of knowing that an incoming session with data is pending.
Since 500KB takes a lot of time, a GUI may choose to read /proc/..../transport
and look if sessions for its socket are pending.

> 
> -> seq_printf(sqf, "iface\tsrc\tdst\tpgn\tdone/total\n");
> 
> Supposed debugging output has to be removed anyway.

ecu, filter & sock are some kind of 'debug'.

see:
net/can/bcm.c L160
net/can/proc.c

I'm willing to remove real 'debug' or 'developer statistics',
but 'transport' stays somehow somewhere. Alternatives are too expensive.

> 
> Things that look fishy:
> 
> #1 (Documentation)
> 
>   Per default j1939 is not active. Specifying can_ifindex != 0 in bind(2)
>   or connect(2) needs an active j1939 on that interface. You must have done
>   $ ip link set canX j1939 on
>   on that interface.
> 
> Eh?
> 
> Never seen something like "ip link set eth0 tcp on" before setting the ip
> address ??
> 

I'm glad you compare with ethernet. In fact, j1939 compares to UDP a bit.

Because ethernet headers have a specific field to indicate 'ip' (or ipv6 or ...),
the software can autodetect to which protocol handler should receive the packet.
CAN just has not such field.
It would be wrong to assume every 29bit frame is j1939 when the module is loaded
on the system.

> Why doesn't it 'just work' ?

I would have preferred that, but it's not feasable.

> 
> #2 (Documentation)
> 
>   Add the address to the system:
>   $ ip addr add j1939 0x20 dev can0
> 
>   Bind:
>     struct sockaddr_can addr;
> 
>     memset(&addr, 0, sizeof(addr));
>     addr.can_ifindex = ifindex("can0"); // ifindex is a substitute.
>     addr.can_addr.j1939.name = J1939_NO_NAME;
>     addr.can_addr.j1939.addr = 0x20;
>     addr.can_addr.j1939.pgn = J1939_NO_PGN;
> 
>     bind(sk, (void *)&addr, sizeof(addr));
> 
> Why does bind() not make the "ip addr add j1939 0x20 dev can0" automatically?

assigning an address to an iface during bind()?
	$ man 2 bind
bind assigns a local address to a socket.
$ ip addr ... assign a local address to an interface.

> 
> #3 (j1939/main.c)
> 
> in static void j1939_can_recv(struct sk_buff *skb, void *data)
> 
>         msg = (void *)skb->data;
>         orig_len = skb->len;
>         skb_pull(skb, CAN_HDR);
>         /* fix length, set to dlc, with 8 maximum */
>         skb_trim(skb, min_t(uint8_t, msg->can_dlc, 8));
> 
> You can not fiddle with skb offsets unless you've cloned it.

I'll fix.
> 
> #4 (segments / ecus / bus / sk / ...)
> 
> Even when trying to follow any concepts in the source code, it's hard to
> follow any idea when these structures and definitions are not described.

ok.
> 
> E.g. why don't you add a j1939_priv pointer to struct dev_rcv_lists when
> CONFIG_CAN_J1939 is enabled?
euhm, can you explain a bit more? 
> 
> Looks like j1939_segment_find() is a frequently used walkthrough function ...
> 
> #5 (j1939/main.c) filters
> 
> #define J1939_CAN_ID    CAN_EFF_FLAG
> #define J1939_CAN_MASK  (CAN_EFF_FLAG | CAN_RTR_FLAG)
> 
>         ret = can_rx_register(netdev, J1939_CAN_ID, J1939_CAN_MASK,
>                         j1939_can_recv, jseg, "j1939");
> 
> You read EVERY EFF frame.
> Filters should be created based on the concrete
> requirement of the userspace (socket).

Your optimizing already?

Note that single J1939 PGN's may map onto multiple CANid's, _and_
single CANid's may result into different J1939 PGN's.

Btw,
	$ ip link set IFACE j1939 on
is explicit.

> 
> #6 (amount of code)
> 
> ls *.c | grep -v mod | xargs wc -l
>    227 address-claim.c
>    523 bus.c
>     76 filter.c
>    458 main.c
>    104 proc.c
>     43 promisc.c
>    306 rtnl.c
>    984 socket.c
>   1449 transport.c
>   4170 total
> 
> Sometimes i feel a much more simple approach is needed.

The major benefit of this code is it's API to userspace.
I'm sure the lines of code can change.
So first issue is to focus on the API.

> 
> You provide a full featured 4 tons SUV IMO no one understands.
> - thousands of knobs to configure
> - and when looking under the hood you get lost from all the cables
> 
> I would like to have a bicycle and probably a quad with AC some days later.
> 
> E.g. with a struct j1939 message having an address field (similar to the
> CAN-ID) with some data behind it.

In contrast to CAN, J1939 features a Source & destination addressing concept,
and variable length packets (up to several Megabytes using ISOBUS extensions).
BSD sockets primitives sendto & recvfrom happen to map 100% to this.

Putting all address info as data just because RAW CAN does this is bad idea.

> 
> That's simple and similar to other implementations.

s/other implementation/straight CAN protocols/
> 
> I might be wrong with this requirement of simplicity.
> But i might be right too.
50% chance?
> 
> Let's wait for beta-testers feedback if your concept is easy to use and adopt
> for j1939 application programmers ...
> 
Kurt
