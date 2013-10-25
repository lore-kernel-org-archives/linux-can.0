From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: CAN Interface on Toradex Board
Date: Fri, 25 Oct 2013 20:24:08 +0200
Message-ID: <526AB748.1040105@grandegger.com>
References: <F1A135976112904197F6276B89309FEF2603BC@sgexc1.bfft.de> <526805E9.1060702@hartkopp.net> <F1A135976112904197F6276B89309FEF2603E1@sgexc1.bfft.de> <35798e892fe0606d15b87c9b366199dc@grandegger.com> <F1A135976112904197F6276B89309FEF26040B@sgexc1.bfft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:55412 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab3JYSYK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Oct 2013 14:24:10 -0400
In-Reply-To: <F1A135976112904197F6276B89309FEF26040B@sgexc1.bfft.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Spies, Raphael | BFFT GmbH" <raphael.spies@bfft.de>
Cc: "'linux-can@vger.kernel.org'" <linux-can@vger.kernel.org>

On 10/24/2013 09:39 AM, Spies, Raphael | BFFT GmbH wrote:
>=20
>> -----Urspr=FCngliche Nachricht-----
>> Von: linux-can-owner@vger.kernel.org [mailto:linux-can-
>> owner@vger.kernel.org] Im Auftrag von Wolfgang Grandegger
>> Gesendet: Donnerstag, 24. Oktober 2013 09:28
>> An: Spies, Raphael | BFFT GmbH
>> Cc: Oliver Hartkopp; linux-can@vger.kernel.org
>> Betreff: Re: AW: CAN Interface on Toradex Board
>>
>> On Thu, 24 Oct 2013 06:44:30 +0000, "Spies, Raphael | BFFT GmbH"
>>
>> <raphael.spies@bfft.de> wrote:

=2E..

>> What does "ip link help" list?
>=20
> sh-4.2# ip link help
> Usage: ip link add [link DEV] [ name ] NAME
>                    [ txqueuelen PACKETS ]
>                    [ address LLADDR ]
>                    [ broadcast LLADDR ]
>                    [ mtu MTU ]
>                    type TYPE [ ARGS ]
>        ip link delete DEV type TYPE [ ARGS ]
>=20
>        ip link set { dev DEVICE | group DEVGROUP } [ { up | down } ]
> 	                  [ arp { on | off } ]
> 	                  [ dynamic { on | off } ]
> 	                  [ multicast { on | off } ]
> 	                  [ allmulticast { on | off } ]
> 	                  [ promisc { on | off } ]
> 	                  [ trailers { on | off } ]
> 	                  [ txqueuelen PACKETS ]
> 	                  [ name NEWNAME ]
> 	                  [ address LLADDR ]
> 	                  [ broadcast LLADDR ]
> 	                  [ mtu MTU ]
> 	                  [ netns PID ]
> 	                  [ netns NAME ]
> 			  [ alias NAME ]
> 	                  [ vf NUM [ mac LLADDR ]
> 				   [ vlan VLANID [ qos VLAN-QOS ] ]
> 				   [ rate TXRATE ] ]=20
> 				   [ spoofchk { on | off} ] ]=20
> 			  [ master DEVICE ]
> 			  [ nomaster ]
>        ip link show [ DEVICE | group GROUP ]
>=20
> TYPE :=3D { vlan | veth | vcan | dummy | ifb | macvlan | can | bridge=
 }

Looks good and therefore I assume that "ip link set can0 type can help"
also works. Anyway, I think the tool does not match for some reason.
Could you try to build the "ip" program from the iproute2 suite [1]
yourself?

[1]
http://www.linuxfoundation.org/collaborate/workgroups/networking/iprout=
e2

Wolfgang.

