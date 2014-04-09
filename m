From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: J1939 test program & Kickstarter guide
Date: Wed, 9 Apr 2014 21:35:04 +0200
Message-ID: <20140409193504.GC15221@vandijck-laurijssen.be>
References: <533BAD63.80202@tataelxsi.co.in>
 <20140402183759.GA4780@vandijck-laurijssen.be>
 <533CFFB7.3020300@tataelxsi.co.in>
 <20140403133934.GA449@vandijck-laurijssen.be>
 <5345572C.60602@tataelxsi.co.in>
 <20140409192811.GB15221@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:64135 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933342AbaDITfQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Apr 2014 15:35:16 -0400
Content-Disposition: inline
In-Reply-To: <20140409192811.GB15221@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: linux-can@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey,

> > 
> > Also can use the can-test(https://gitorious.org/linux-can/can-tests)
> > applications for validating j1939 socket,off-course with the J1929
> > related modifications.
> 
> I have not yet added such thing.
> I did post in the recent past some sources together with a preliminary
> kickstarter guide.

I just attached sample testprogram & guide how to use it.

Kind regards,
Kurt

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="j1939.page"

# CAN-J1939 on linux

## CAN on linux

See [Wikipedia:socketcan](http://en.wikipedia.org/wiki/Socketcan)

## J1939 networking in short

* Add addressing on top of CAN (destination address & broadcast)

* Any (max 1780) length packets.
  Packets of 9 or more use **Transport Protocol** (fragmentation)
  Such packets use different CANid for the same PGN.

* only **29**bit, non-**RTR** CAN frames

* CAN id is composed of
  * 0..8: SA (source address)
  * 9..26:
    * PDU1: PGN+DA (destionation address)
    * PDU2: PGN
  * 27..29: PRIO

* SA / DA may be dynamically assigned via j1939-81  
  Fixed rules of precedence in Specification, no master necessary

## J1939 on SocketCAN

J1939 is *just another protocol* that fits
in the Berkely sockets.

	socket(AF_CAN, SOCK_DGRAM, CAN_J1939)

## differences from CAN_RAW
### addressing

SA, DA & PGN are used, not CAN id.

Berkeley socket API is used to communicate these to userspace:

  * SA+PGN is put in sockname ([getsockname](http://man7.org/linux/man-pages/man2/getsockname.2.html))
  * DA+PGN is put in peername ([getpeername](http://man7.org/linux/man-pages/man2/getpeername.2.html))  
    PGN is put in both structs

PRIO is a datalink property, and irrelevant for interpretation
Therefore, PRIO is not in *sockname* or *peername*.

The *data* that is [recv][recvfrom] or [send][sendto] is the real payload.
Unlike CAN_RAW, where addressing info is data.

### Packet size

J1939 handles packets of 8+ bytes with **Transport Protocol** fragmentation transparently.
No fixed data size is necessary.

	send(sock, data, 8, 0);

will emit a single CAN frame.

	send(sock, data, 9, 0);

will use fragementation, emitting 1+ CAN frames.

# Enable j1939

CAN has no protocol id field.
Enabling protocols must be done manually

### netlink

	ip link set can0 j1939 on

### procfs for legacy kernel (2.6.25)

This API is dropped for kernels with netlink support!

	echo can0 > /proc/net/can-j1939/net

# Using J1939

## BSD socket implementation
* socket
* bind / connect
* recvfrom / sendto
* getsockname / getpeername

## Modified *struct sockaddr_can*

	struct sockaddr_can {
		sa_family_t can_family;
		int         can_ifindex;
		union {
			struct {
				__u64 name;
				__u32 pgn;
				__u8 addr;
			} j1939;
		} can_addr;
	}

* *can_addr.j1939.pgn* is PGN

* *can_addr.j1939.addr* & *can_addr.j1939.name*  
  determine the ECU

  * receiving address information,  
    *addr* is always set,  
    *name* is set when available.

  * When providing address information,  
    *name* != 0 indicates dynamic addressing

## iproute2

### Static addressing

	ip addr add j1939 0x80 dev can0

### Dynamic addressing

	ip addr add j1939 name 0x012345678abcdef dev can0

# Kickstart guide to j1939 on linux

## Prepare using VCAN

You may skip this step entirely if you have a functional
**can0** bus on your system.

Load module, when *vcan* is not in-kernel

	modprobe vcan

Create a virtual can0 device and start the device

	ip link add can0 type vcan
	ip link set can0 up

## First steps with j1939

Use [testj1939](testj1939.c)

When *can-j1939* is compiled as module, load it.

	modprobe can-j1939

Enable the j1939 protocol stack on the CAN device

	ip link set can0 j1939 on

Most of the subsequent examples will use 2 sockets programs (in 2 terminals).
One will use CAN_J1939 sockets using *testj1939*,
and the other will use CAN_RAW sockets using cansend+candump.

testj1939 can be told to print the used API calls by adding **-v** program argument.

### receive without source address

Do in terminal 1

	./testj1939 -r can0:

Send raw CAN in terminal 2

	cansend can0 1823ff40#0123

You should have this output in terminal 1

	40 02300: 01 23

This means, from NAME 0, SA 40, PGN 02300 was received,
with 2 databytes, *01* & *02*.

now emit this CAN message:

	cansend can0 18234140#0123

In J1939, this means that ECU 0x40 sends directly to ECU 0x41
Since we did not bind to address 0x41, this traffic
is not meant for us and *testj1939* does not receive it.

### Use source address

	./testj1939 can0:0x80

will say

	./testj1939: bind(): Cannot assign requested address

Since J1939 maintains addressing, **0x80** has not yet been assigned
as an address on **can0** . This behaviour is very similar to IP
addressing: you cannot bind to an address that is not your own.

Now tell the kernel that we *own* address 0x80.
It will be available from now on.

	ip addr add j1939 0x80 dev can0
	./testj1939 can0:0x80

now succeeds.

### receive with source address

Terminal 1:

	./testj1939 -r can0:0x80

Terminal 2:

	cansend can0 18238040#0123

Will emit this output

	40 02300: 01 23

This is because the traffic had destination address __0x80__ .

### send

Open in terminal 1:

	candump -L can0

And to these test in another terminal

	./testj1939 -s can0:0x80

This produces **1BFFFF80#0123456789ABCDEF** on CAN.

	./testj1939 -s can0:

will produce exactly the same because **0x80** is the only
address currently assigned to **can0:** and is used by default.

### Multiple source addresses on 1 CAN device

	ip addr add j1939 0x90 dev can0

	./testj1939 -s can0:0x90

produces **1BFFFF90#0123456789ABCDEF** ,

	./testj1939 -s can0:

still produces **1BFFFF80#0123456789ABCDEF** , since **0x80**
is the default _source address_.
Check

	ip addr show can0

emits

	X: can0: <NOARP,UP,LOWER_UP> mtu 16 qdisc noqueue state UNKNOWN 
	    link/can 
	    can-j1939 0x80 scope link 
	    can-j1939 0x90 scope link

0x80 is the first address on can0.

### Use specific PGN

	./testj1939 -s can0:,0x12345

emits **1923FF80#0123456789ABCDEF** .

Note that the real PGN is **0x12300**, and destination address is **0xff**.

### Emit destination specific packets

The destination field may be set during sendto().
*testj1939* implements that like this

	./testj1939 -s can0:,0x12345 can0:0x40

emits **19234080#0123456789ABCDEF** .

The destination CAN iface __must__ always match the source CAN iface.
Specifing one during bind is therefore sufficient.

	./testj1939 -s can0:,0x12300 :0x40

emits the very same.

### Emit different PGNs using the same socket

The PGN is provided in both __bind( *sockname* )__ and
__sendto( *peername* )__ , and only one is used.
*peername* PGN has highest precedence.

For broadcasted transmissions

	./testj1939 -s can0:,0x12300 :,0x32100

emits **1B21FF80#0123456789ABCDEF** rather than 1923FF80#012345678ABCDEF

Desitination specific transmissions

	./testj1939 -s can0:,0x12300 :0x40,0x32100

emits **1B214080#0123456789ABCDEF** .

It makes sometimes sense to omit the PGN in __bind( *sockname* )__ .

### Larger packets

J1939 transparently switches to *Transport Protocol* when packets
do not fit into single CAN packets.

	./testj1939 -s20 can0:0x80 :,0x12300

emits:

	18ECFF80#20140003FF002301
	18EBFF80#010123456789ABCD
	18EBFF80#02EF0123456789AB
	18EBFF80#03CDEF01234567

The fragments for broadcasted *Transport Protocol* are seperated
__50ms__ from each other.  
Destination specific *Transport Protocol* applies flow control
and may emit CAN packets much faster.

	./testj1939 -s20 can0:0x80 :0x90,0x12300

emits:

	18EC9080#1014000303002301
	18EC8090#110301FFFF002301
	18EB9080#010123456789ABCD
	18EB9080#02EF0123456789AB
	18EB9080#03CDEF01234567
	18EC8090#13140003FF002301

The flow control causes a bit overhead.
This overhead scales very good for larger J1939 packets.

## Advanced topics with j1939

### Change priority of J1939 packets

	./testj1939 -s can0:0x80,0x0100
	./testj1939 -s -p3 can0:0x80,0x0200

emits
	
	1801FF80#0123456789ABCDEF	
	0C02FF80#0123456789ABCDEF

### using connect

### advanced filtering

## dynamic addressing


--ZPt4rx8FFjLCG7dd
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="testj1939.c"

/*
 * Copyright (c) 2013 EIA Electronics
 *
 * Authors:
 * Kurt Van Dijck <kurt.van.dijck@eia.be>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the version 2 of the GNU General Public License
 * as published by the Free Software Foundation
 */

#include <signal.h>
#include <time.h>
#include <inttypes.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include <unistd.h>
#include <getopt.h>
#include <error.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <net/if.h>
#include <linux/can.h>
#include <linux/can/j1939.h>

static const char help_msg[] =
	"testj1939: demonstrate j1939 use\n"
	"Usage: testj1939 FROM TO\n"
	" FROM / TO	- or [IFACE][:[SA][,[PGN][,NAME]]]\n"
	"Options:\n"
	" -v		Print relevant API calls\n"
	" -s[=LEN]	Initial send of LEN bytes dummy data\n"
	" -r		Receive (and print) data\n"
	" -e		Echo incoming packets back\n"
	"		This atually receives packets\n"
	" -c		Issue connect()\n"
	" -p=PRIO	Set priority to PRIO\n"
	" -n		Emit 64bit NAMEs in output\n"
	"\n"
	"Example:\n"
	"testj1939 can1 20\n"
	"\n"
	;

static const char optstring[] = "?vs::rep:cn";

static void parse_canaddr(char *spec, struct sockaddr_can *paddr)
{
	char *str;

	str = strsep(&spec, ":");
	if (strlen(str))
		paddr->can_ifindex = if_nametoindex(str);

	str = strsep(&spec, ",");
	if (str && strlen(str))
		paddr->can_addr.j1939.addr = strtoul(str, NULL, 0);

	str = strsep(&spec, ",");
	if (str && strlen(str))
		paddr->can_addr.j1939.pgn = strtoul(str, NULL, 0);

	str = strsep(&spec, ",");
	if (str && strlen(str))
		paddr->can_addr.j1939.name = strtoul(str, NULL, 0);
}

static const char *canaddr2str(const struct sockaddr_can *paddr)
{
	static char buf[128];
	char *str = buf;
	char ifname[IF_NAMESIZE];

	if (paddr->can_ifindex)
		str += sprintf(str, "%s", if_indextoname(paddr->can_ifindex, ifname));
	*str++ = ':';

	if (paddr->can_addr.j1939.addr != J1939_NO_ADDR)
		str += sprintf(str, "%02x", paddr->can_addr.j1939.addr);
	*str++ = ',';
	if (paddr->can_addr.j1939.pgn != J1939_NO_PGN)
		str += sprintf(str, "%05x", paddr->can_addr.j1939.pgn);
	*str++ = ',';
	if (paddr->can_addr.j1939.name != J1939_NO_NAME)
		str += sprintf(str, "%016llx", paddr->can_addr.j1939.name);
	*str++ = 0;
	return buf;
}

/* main */
int main(int argc, char *argv[])
{
	int ret, sock, opt, j, verbose;
	socklen_t peernamelen;
	struct sockaddr_can sockname = {
		.can_family = AF_CAN,
		.can_addr.j1939 = {
			.addr = J1939_NO_ADDR,
			.name = J1939_NO_NAME,
			.pgn = J1939_NO_PGN,
		},
	}, peername = {
		.can_family = AF_CAN,
		.can_addr.j1939 = {
			.addr = J1939_NO_ADDR,
			.name = J1939_NO_NAME,
			.pgn = J1939_NO_PGN,
		},
	};
	uint8_t dat[128];
	int valid_peername = 0;
	int todo_send = 0, todo_recv = 0, todo_echo = 0, todo_prio = -1;
	int todo_connect = 0, todo_names = 0;

	/* argument parsing */
	while ((opt = getopt(argc, argv, optstring)) != -1)
	switch (opt) {
	case 'v':
		verbose = 1;
		break;
	case 's':
		todo_send = strtoul(optarg ?: "8", NULL, 0);
		break;
	case 'r':
		todo_recv = 1;
		break;
	case 'e':
		todo_echo = 1;
		break;
	case 'p':
		todo_prio = strtoul(optarg, NULL, 0);
		break;
	case 'c':
		todo_connect = 1;
		break;
	case 'n':
		todo_names = 1;
		break;
	default:
		fputs(help_msg, stderr);
		exit(1);
		break;
	}

	if (argv[optind]) {
		if (strcmp("-", argv[optind]))
			parse_canaddr(argv[optind], &sockname);
		++optind;
	}

	if (argv[optind]) {
		if (strcmp("-", argv[optind])) {
			parse_canaddr(argv[optind], &peername);
			valid_peername = 1;
		}
		++optind;
	}

	/* open socket */
	if (verbose)
		fprintf(stderr, "- socket(PF_CAN, SOCK_DGRAM, CAN_J1939);\n");
	sock = ret = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	if (ret < 0)
		error(1, errno, "socket(j1939)");

	if (todo_prio >= 0) {
		if (verbose)
			fprintf(stderr, "- setsockopt(, SOL_CAN_J1939, SO_J1939_SEND_PRIO, &%i);\n", todo_prio);
		ret = setsockopt(sock, SOL_CAN_J1939, SO_J1939_SEND_PRIO,
				&todo_prio, sizeof(todo_prio));
		if (ret < 0)
			error(1, errno, "set priority %i", todo_prio);
	}

	if (verbose)
		fprintf(stderr, "- bind(, %s, %li);\n", canaddr2str(&sockname), sizeof(sockname));
	ret = bind(sock, (void *)&sockname, sizeof(sockname));
	if (ret < 0)
		error(1, errno, "bind()");

	if (todo_connect) {
		if (!valid_peername)
			error(1, 0, "no peername supplied");
		if (verbose)
			fprintf(stderr, "- connect(, %s, %li);\n", canaddr2str(&peername), sizeof(peername));
		ret = connect(sock, (void *)&peername, sizeof(peername));
		if (ret < 0)
			error(1, errno, "connect()");
	}

	if (todo_send) {
		/* initialize test vector */
		for (j = 0; j < sizeof(dat); ++j)
			dat[j] = ((2*j) << 4) + ((2*j+1) & 0xf);

		/* send data */
		/*
		 * when using connect, do not provide additional
		 * destination information and use send()
		 */
		if (valid_peername && !todo_connect) {
			if (verbose)
				fprintf(stderr, "- sendto(, <dat>, %i, 0, %s, %li);\n", todo_send, canaddr2str(&peername), sizeof(peername));
			ret = sendto(sock, dat, todo_send, 0,
					(void *)&peername, sizeof(peername));
		} else {
			/*
			 * we may do sendto(sock, dat, todo_send, 0, NULL, 0)
			 * as well, but using send() demonstrates the API better
			 */
			if (verbose)
				fprintf(stderr, "- send(, <dat>, %i, 0);\n", todo_send);
			ret = send(sock, dat, todo_send, 0);
		}

		if (ret < 0)
			error(1, errno, "sendto");
	}

	/* main loop */
	if ((todo_echo || todo_recv) && verbose)
		fprintf(stderr, "- while (1)\n");
	while (todo_echo || todo_recv) {
		/*
		 * re-use peername for storing the sender's peername of
		 * received packets
		 */
		if (verbose)
			fprintf(stderr, "- recvfrom(, <dat>, %li, 0, &<peername>, %li);\n", sizeof(peername), sizeof(peername));
		peernamelen = sizeof(peername);
		ret = recvfrom(sock, dat, sizeof(dat), 0,
				(void *)&peername, &peernamelen);
		if (ret < 0) {
			if (EINTR == errno) {
				if (verbose)
					fprintf(stderr, "-\t<interrupted>\n");
				continue;
			}
			error(1, errno, "recvfrom()");
		}

		if (todo_echo) {
			if (verbose)
				fprintf(stderr, "- sendto(, <dat>, %i, 0, %s, %i);\n", ret, canaddr2str(&peername), peernamelen);
			ret = sendto(sock, dat, ret, 0,
					(void *)&peername, peernamelen);
			if (ret < 0)
				error(1, errno, "sendto");
		}
		if (todo_recv) {
			if (todo_names && peername.can_addr.j1939.name)
				printf("%016llx ", peername.can_addr.j1939.name);
			printf("%02x %05x:", peername.can_addr.j1939.addr,
					peername.can_addr.j1939.pgn);
			for (j = 0; j < ret; ++j)
				printf(" %02x", dat[j]);
			printf("\n");
		}
	}
	return 0;
}


--ZPt4rx8FFjLCG7dd--
