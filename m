From: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Subject: Re: increase buffer size
Date: Tue, 24 Jan 2012 13:01:45 +0100
Message-ID: <4F1E9DA9.9060804@hartkopp.net>
References: <1567213.2GCzMlGyKY@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <1567213.2GCzMlGyKY@lisa>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Steffen Rose <ro-2q5hN/w50hk@public.gmane.org>
Cc: socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Steffen,

On 24.01.2012 12:18, Steffen Rose wrote:

> I want to increase the transmit quere of a can device.


You can do this with ifconfig or the 'ip' tool from the iproute2 package.

Examples:

ifconfig can0 txqueuelen 1000

or

ip link set can0 txqueuelen 1000


> 
> As I understand, the virtual devices don't have a quere. Is it right?
> 


Generally yes. A vcan is a software device like the 'lo' interface for IP.
Both (vcan & lo) transfer the packets directly back to the rx queue instantly.

But you can create vcans having a tx-queue len:

Here i created a virtual CAN interface 'xxx' with a txqueuelen of 10:

root# ip link add xxx type vcan
root# ip link set xxx txqueuelen 10
root# ip link set xxx up
root# ip link show xxx
10: xxx: <NOARP,UP,LOWER_UP> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
root#

But this has no effect as long as you do not add some kind of queueing
discipline that throttles the bandwidth on the specific interface.

> As I understand, for physical devices the transmit quere is located within the 
> sockets, not in the can device driver. Is it right?


The tx buffers of the sockets are not really used e.g. for CAN_RAW sockets.
The tx queue len of the CAN network interface are relevant for you.

> 
> Do you have an small code snippet for the changing of the quere size?


Better use the tools stated above.

But you can (as root) modify these values e.g. with netlink sockets.

Regards,
Oliver

ps.

please do not use this mailing list any longer but send your questions
to the new "linux-can" mailing list address "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org".
For subscription or mailing list archives please have a look to:

   http://vger.kernel.org/vger-lists.html#linux-can

Mail archives of the new linux-can mailing list can be found at:

   http://dir.gmane.org/gmane.linux.can
   http://marc.info/?l=linux-can&r=1&w=2
