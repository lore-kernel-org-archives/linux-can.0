From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2] ip: add handling for new CAN netlink interface
Date: Tue, 30 May 2017 17:40:16 -0700
Message-ID: <20170530174016.65cf8608@xeon-e3>
References: <20170519125449.7214-1-remigiusz.kollataj@mobica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170519125449.7214-1-remigiusz.kollataj@mobica.com>
Sender: netdev-owner@vger.kernel.org
To: Remigiusz =?UTF-8?B?S2/FgsWCxIV0YWo=?= <remigiusz.kollataj@mobica.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Fri, 19 May 2017 14:54:49 +0200
Remigiusz Ko=C5=82=C5=82=C4=85taj         <remigiusz.kollataj@mobica.com> w=
rote:

> This patch adds handling for new CAN netlink interface introduced in
> 4.11 kernel:
> - IFLA_CAN_TERMINATION,
> - IFLA_CAN_TERMINATION_CONST,
> - IFLA_CAN_BITRATE_CONST,
> - IFLA_CAN_DATA_BITRATE_CONST
>=20
> Output example:
> $ip -d link show can0
> 6: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group def=
ault qlen 10
>     link/can  promiscuity 0
>     can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
>           bitrate 80000
>              [   20000,    33333,    50000,    80000,    83333,   100000,
>                 125000,   150000,   175000,   200000,   225000,   250000,
>                 275000,   300000,   500000,   625000,   800000,  1000000 ]
>           termination 0 [ 0, 120 ]
>           clock 0numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_s=
egs 65535
>=20
> Signed-off-by: Remigiusz Ko=C5=82=C5=82=C4=85taj <remigiusz.kollataj@mobi=
ca.com>

Applied, thanks for confirming the output change.
