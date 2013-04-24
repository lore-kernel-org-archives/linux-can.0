From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Wed, 24 Apr 2013 16:49:29 +0200
Message-ID: <20130424144929.GA2077@vandijck-laurijssen.be>
References: <5169B395.2070703@hartkopp.net>
 <516D2ABB.4000300@pengutronix.de>
 <5177A090.6010904@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:23074 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751780Ab3DXOth (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Apr 2013 10:49:37 -0400
Content-Disposition: inline
In-Reply-To: <5177A090.6010904@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephane,

I have written this some time ago, not using it actually.
I tried a modular approach, don't know if its usefull.

PS: I used attachments.

Kurt

On Wed, Apr 24, 2013 at 11:06:24AM +0200, Stephane Grosjean wrote:
> Hi linux-can members,
>=20
> I currently wonder whether it exists any way of getting the list of
> the installed CAN interfaces, from a C program?
> I mean, getting the network interfaces list is available using
> ioctl(SIOCGIFCONF).
> But AFAIK, this (only) returns the IP interfaces found in the
> system, even using a socket CAN file descriptor.
> And, I would also like to avoid some pipe/fork/grep/sed in this C
> program too ;-)
>=20
> Thanks for your help and best regards,
>=20
> St=C3=A9phane
> --
> PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt
> Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA
> Darmstadt HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.:
> DE39305391 Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329,
> info@peak-system.com
> ----
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534

--a8Wt8u1KmwUX3Y2C
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="enumif.c"

#ifdef linux
#if linux

#include <stdio.h>
#include <string.h>
#include <errno.h>

#include <unistd.h>
#include <sys/socket.h>
#include <linux/rtnetlink.h>
#include <linux/netlink.h>

#include "enumif.h"

static struct {
	int sock;
	int seq;
} s = {
	.sock = -1,
};

__attribute__((destructor))
void enumif_cleanup(void)
{
	if (s.sock >= 0) {
		close(s.sock);
		s.sock = -1;
	}
}

static int enumif_open(void)
{
	int fd;
	struct sockaddr_nl local = {
		.nl_family = AF_NETLINK,
		.nl_groups = 0,
	};

	if (s.sock >= 0)
		return s.sock;

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (fd < 0) {
		perror("Cannot open netlink socket");
		return -1;
	}

	if (bind(fd, (struct sockaddr *)&local, sizeof(local)) < 0) {
		perror("Cannot bind netlink socket");
		return -1;
	}
	s.sock = fd;
	s.seq = 0;
	return fd;
}

static inline int enumif_send_request(int sk)
{
	struct {
		struct nlmsghdr n;
		struct rtgenmsg g;
	} req = {
		.n = {
			.nlmsg_len = sizeof(req),
			.nlmsg_type = RTM_GETLINK,
			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ROOT | NLM_F_MATCH,
			.nlmsg_pid = 0,
			.nlmsg_seq = ++s.seq,
		},
		.g.rtgen_family = AF_PACKET,
	};
	return send(sk, &req, sizeof(req), 0);
}

static void parse_rtattr(struct rtattr **tb, int max,
		struct rtattr *rta, int len)
{
	memset(tb, 0, sizeof(*tb) * max);
	while (RTA_OK(rta, len)) {
		if (rta->rta_type <= max) {
			tb[rta->rta_type] = rta;
		}

		rta = RTA_NEXT(rta, len);
	}
}

int enumif(void (*fn)(const char *name, int ifindex, int type, int flags, int state))
{
	int ret, n_if = 0;
	size_t msglen;
	struct nlmsghdr *h;
	struct sockaddr_nl peer;
	char cbuf[128];
	char buf[1024 * 16];
	struct iovec iov = {
		.iov_base = buf,
		.iov_len = sizeof(buf),
	};
	struct msghdr msg = {
		.msg_name = (void *)&peer,
		.msg_namelen = sizeof(peer),
		.msg_iov = &iov,
		.msg_iovlen = 1,
		.msg_control = &cbuf,
		.msg_controllen = sizeof(cbuf),
		.msg_flags = 0,
	};
	struct ifinfomsg *ifi;
	struct rtattr *tb[IFLA_MAX + 1];

	if (enumif_open() < 0)
		return -1;

	if (enumif_send_request(s.sock) < 0) {
		perror("Cannot send dump request");
		return -1;
	}

	while (1) {
		iov.iov_len = sizeof(buf);

		ret = recvmsg(s.sock, &msg, 0);
		if (ret < 0) {
			if (errno == EINTR || errno == EAGAIN)
				continue;
			perror("netlink receive error");
			return -1;
		}
		if (ret == 0) {
			errno = 0;
			perror("netlink EOF?");
			return -1;
		}
		msglen = ret;
		for (h = (void *)buf; NLMSG_OK(h, msglen);
				h = NLMSG_NEXT(h, msglen)) {
			if (h->nlmsg_type == NLMSG_DONE)
				goto done;
			if (h->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = (struct nlmsgerr*)NLMSG_DATA(h);
				if (h->nlmsg_len < NLMSG_LENGTH(sizeof(struct nlmsgerr))) {
					fprintf(stderr,
						"ERROR truncated\n");
				} else {
					errno = -err->error;
					perror("RTNETLINK answers");
				}
				return -1;
			}
			++n_if;
			ifi = NLMSG_DATA(h);
			parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(h));
                        
			fn(RTA_DATA(tb[IFLA_IFNAME]), ifi->ifi_index, ifi->ifi_type,
					ifi->ifi_flags,
					*(unsigned char *)RTA_DATA(tb[IFLA_OPERSTATE]));
		}
	}

done:
	return 0;
}

#endif
#endif


--a8Wt8u1KmwUX3Y2C
Content-Type: text/x-chdr; charset=utf-8
Content-Disposition: attachment; filename="enumif.h"

#ifndef _enumif_h_
#define _enumif_h_
#ifdef __cplusplus
extern "C" {
#endif

#ifdef linux
#if linux
extern int enumif(void (*fn)(const char *name, int ifindex, int type, int flags, int state));
#endif
#endif

#ifdef __cplusplus
}
#endif
#endif

--a8Wt8u1KmwUX3Y2C
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="enumif-test.c"

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <linux/if.h>
#include <linux/if_arp.h>

#include "enumif.h"

struct lookup {
	int i;
	const char *a;
};

#define __PF(f,n) { ARPHRD_##f, #n },
static const struct lookup iftypes[] = {
	{ 0, "generic", },
__PF(ETHER,ether)
__PF(EETHER,eether)
__PF(AX25,ax25)
__PF(PRONET,pronet)
__PF(CHAOS,chaos)
__PF(IEEE802,ieee802)
__PF(ARCNET,arcnet)
__PF(APPLETLK,atalk)
__PF(DLCI,dlci)
__PF(ATM,atm)
__PF(METRICOM,metricom)
__PF(IEEE1394,ieee1394)
__PF(INFINIBAND,infiniband)
__PF(SLIP,slip)
__PF(CSLIP,cslip)
__PF(SLIP6,slip6)
__PF(CSLIP6,cslip6)
__PF(RSRVD,rsrvd)
__PF(ADAPT,adapt)
__PF(ROSE,rose)
__PF(X25,x25)
__PF(HWX25,hwx25)
__PF(CAN,can)
__PF(PPP,ppp)
__PF(HDLC,hdlc)
__PF(LAPB,lapb)
__PF(DDCMP,ddcmp)
__PF(RAWHDLC,rawhdlc)
__PF(TUNNEL,ipip)
__PF(TUNNEL6,tunnel6)
__PF(FRAD,frad)
__PF(SKIP,skip)
__PF(LOOPBACK,loopback)
__PF(LOCALTLK,ltalk)
__PF(FDDI,fddi)
__PF(BIF,bif)
__PF(SIT,sit)
__PF(IPDDP,ip/ddp)
__PF(IPGRE,gre)
__PF(PIMREG,pimreg)
__PF(HIPPI,hippi)
__PF(ASH,ash)
__PF(ECONET,econet)
__PF(IRDA,irda)
__PF(FCPP,fcpp)
__PF(FCAL,fcal)
__PF(FCPL,fcpl)
__PF(FCFABRIC,fcfb0)
__PF(FCFABRIC+1,fcfb1)
__PF(FCFABRIC+2,fcfb2)
__PF(FCFABRIC+3,fcfb3)
__PF(FCFABRIC+4,fcfb4)
__PF(FCFABRIC+5,fcfb5)
__PF(FCFABRIC+6,fcfb6)
__PF(FCFABRIC+7,fcfb7)
__PF(FCFABRIC+8,fcfb8)
__PF(FCFABRIC+9,fcfb9)
__PF(FCFABRIC+10,fcfb10)
__PF(FCFABRIC+11,fcfb11)
__PF(FCFABRIC+12,fcfb12)
__PF(IEEE802_TR,tr)
__PF(IEEE80211,ieee802.11)
__PF(IEEE80211_PRISM,ieee802.11/prism)
__PF(IEEE80211_RADIOTAP,ieee802.11/radiotap)
#ifdef ARPHD_IEEE802154
__PF(IEEE802154, ieee802.15.4)
#endif
#ifdef ARPHD_PHONET
__PF(PHONET, phonet)
#endif
#ifdef ARPHD_PIPE
__PF(PHONET_PIPE, phonet_pipe)
#endif

__PF(NONE, none)
__PF(VOID,void)
	{ },
};

#define __IF(f)	{ IFF_##f, #f, }
static const struct lookup ifflags[] = {
	__IF(LOOPBACK),
	__IF(BROADCAST),
	__IF(POINTOPOINT),
	__IF(MULTICAST),
	__IF(NOARP),
	__IF(ALLMULTI),
	__IF(PROMISC),
	__IF(MASTER),
	__IF(SLAVE),
	__IF(DEBUG),
	__IF(DYNAMIC),
	__IF(AUTOMEDIA),
	__IF(PORTSEL),
	__IF(NOTRAILERS),
	__IF(UP),
	__IF(LOWER_UP),
	__IF(DORMANT),
	__IF(ECHO),
	{},
};

static const char *statestrs[] = {
	"UNKNOWN", "NOTPRESENT", "DOWN", "LOWERLAYERDOWN", 
	"TESTING", "DORMANT",	 "UP"
};

static void ifcallback(const char *name, int index, int type, int flags, int state)
{
	const struct lookup *lp;
	char typestr[16];


	sprintf(typestr, "%i", type);
	for (lp = iftypes; lp->a; ++lp)
		if (lp->i == type)
			break;
	printf("%i: %s\t{%s}", index, name, lp->a ?: typestr);

	printf(" <");
	/* from iproute2 */
	if ((flags & IFF_UP) && !(flags & IFF_RUNNING))
		printf("%s%s", "NO-CARRIER", flags ? "," : "");
	flags &= ~IFF_RUNNING;

	for (lp = ifflags; lp->a; ++lp) {
		if (flags & lp->i) {
			flags &= ~lp->i;
			printf("%s%s", lp->a, flags ? "," : "");
		}
	}
	if (flags)
		printf("%x", flags);
	printf("> %s\n", statestrs[state]);
}

int main(int argc, char *argv[])
{
	enumif(ifcallback);
	return 0;
}


--a8Wt8u1KmwUX3Y2C--
