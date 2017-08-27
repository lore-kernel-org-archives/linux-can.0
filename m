From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: SO_BINDTODEVICE semantics
Date: Sun, 27 Aug 2017 20:53:28 +0200
Message-ID: <20170827185328.GB17219@airbook.vandijck-laurijssen.be>
References: <20170827181350.GA17219@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:53602 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdH0Sxf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 27 Aug 2017 14:53:35 -0400
Content-Disposition: inline
In-Reply-To: <20170827181350.GA17219@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de


> 
> --- Original message ---
> > 
> > On 08/25/2017 08:46 PM, Kurt Van Dijck wrote:
> > >Hey Oliver,
> > >
> > >>On 08/25/2017 11:34 AM, Kurt Van Dijck wrote:
> > >>>>On 08/24/2017 04:11 PM, Kurt Van Dijck wrote:
> > >>>>>>>This patch removes the struct raw_sock::ifindex from the CAN raw socket
> > >>>>>>>and uses the already existing sock::sk_bound_dev_if instead.
> > >>>>>>
> > >>>>>>I would like to omit this patch.
> > >>>>>>
> > >>>>>>1. It does NOT increase the readability ;-)
> > >>>>>>
> > >>>>>>ifindex points out that we are handling an interface index.
> > >>>>>>sk_bound_dev_if could be anything.
> > >>>>>
> > >>>>>See http://elixir.free-electrons.com/linux/v4.12.8/source/net/core/sock.c#L617
> > >>>>>sk_bound_dev_if may be a difficult name, but could not be anything.
> > >>>>>It allow to use SO_BINDTODEVICE (man 7 socket) to work properly for can raw sockets too.
> > >>>>
> > >>>>When ro->ifindex = 0 it can still be bound in the case of CAN sockets.
> > >>>>There is a different semantic as ifindex = zero means 'all CAN interfaces'
> > >>>>and not 'no interface'.
> > >>>
> > >>>ro->ifindex = 0: accept traffic from all interfaces
> > >>>ro->ifindex != 0: accept traffic only from 1 iface
> > >>>
> > >>>sk_bound_dev_if = 0: accept traffic from all interfaces
> > >>>sk_bound_dev_if != 0: accept traffic only from 1 iface
> > >>>
> > >>>What is the semantic difference?
> > >>
> > >>man 7 socket
> > >>
> > >>SO_BINDTODEVICE
> > >>
> > >>Bind this socket to a particular device like “eth0”, as specified in the
> > >>passed interface name.  If the name  is  an empty  string  or the option
> > >>length is zero, the socket device binding is removed.  The passed option is
> > >>a variable-length null-terminated interface name string with the maximum
> > >>size of IFNAMSIZ.  If a socket is bound to  an  interface,  only  packets
> > >>received from that particular interface are processed by the socket. Note
> > >>that this works only for some socket types, particularly AF_INET sockets.
> > >>It is not supported for packet  sockets  (use  normal bind(2) there).
> > >
> > >A verbatim copy of the man page isn't helping. I have read it.
> > >
> > >>
> > >>Especially "If the name  is  an empty  string  or the option length is zero,
> > >>the socket device binding is removed." is wrong.
> > >
> > >Do you mean the man page is wrong?
> > >Or do you mean that the semantic difference is wrong?
> > 
> > Yes. It tells us:
> > 
> > "If the name  is  an empty  string  or the option length is zero, the socket
> > device binding is removed."
> > 
> > Which means the status of 'bind' is NOT decoupled from the number in
> > ifindex.
> > 
> > A provided empty string leads to an unbound socket - and not to a socket
> > bound to ifindex=0 which is intended with CAN sockets.
> 
> Ok, this is not how I interpreted the man page.
> This would also be an assymetric behaviour:
> SO_BINDTODEVICE(eth0) does not bind anything.
> SO_BINDTODEVICE("") should not unbind either.
> 
> I'll go check the code ...
> or write a small test program.
> 
> > 
> > Ok. We should omit this patch.
> > 
so my tiny little test program:

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/udp.h>

int main(int argc, char *argv[])
{
	int sock;
	int ret;
	struct sockaddr_in6 myaddr = {
		.sin6_family = AF_INET6,
		.sin6_port = htons(1024),
		.sin6_addr = IN6ADDR_ANY_INIT,
	}, peeraddr;
	socklen_t len;
	static uint8_t buf[1024];
	char *str;

	sock = socket(PF_INET6, SOCK_DGRAM, 0);
	if (sock < 0)
		return 1;

	if (argc > 1) {
		ret = setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE, argv[1], strlen(argv[1]));
		if (ret < 0)
			return 1;
	}
	ret = bind(sock, (void *)&myaddr, sizeof(myaddr));
	if (ret < 0)
		return 1;

	for (;;) {
		len = sizeof(&peeraddr);
		ret = recvfrom(sock, buf, sizeof(buf)-1, 0, (void *)&peeraddr, &len);
		if (ret < 0)
			return 1;
		buf[ret] = 0;
		str = strtok((char *)buf, " \t\r\n");
		ret = setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE, str, strlen(str ?: ""));
		if (ret < 0)
			return 1;
#if 0
		ret = sendto(sock, "hello there\n", 12, 0, (void *)&peeraddr, len);
		if (ret < 0)
			return 1;
#endif
	}
	return 0;
}

how to use:
have 2 terminals, one on localhost and one on another computer on the
network:

3rd terminal:
	sudo strace ./sobindtodevice
	# that's what I called my program :-)
	# rather than doing failure reporting, I rely on strace
2rd terminal over network
	nc -u <yourname> 1024
		lo	# will change to localhost, will succeed
		lo	# will fail, because <yourname> isn't listening
			# anymore on th network
Now comes the prove:
1rd terminal on localhost
	nc -u localhost 1024
			# empy line, so the device binding is gone, succeeds
2rd terminal over network
	nc -u <yourname> 1024
			# empy line, so the device binding is gone, succeeds
1rd terminal on localhost
	nc -u localhost 1024
		lo	# succeeds
		lo	# succeeds

It's a bit hard to follow since you need a remote PC to verify
(at least, I did).
As you notice, the 'bind()' is never reverted, only the 'device binding'
changes.

> > But I'm more interested in convincing you than just omitting this patch to
> > not block the upstream process ;-)

You convinced me to find out to the bottom :-)
Does your interpretation of 'device binding' still stand?

[feeling a bit euforious]
I guess you learned something new today?

