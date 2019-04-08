From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Date: Mon, 8 Apr 2019 17:46:02 +0000
Message-ID: <385f7948-d12b-1fc2-2ed2-23d1e76034a0@nxp.com>
References: <20190319051512.14950-3-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319051512.14950-3-qiangqing.zhang@nxp.com>
Content-Language: en-US
Content-ID: <FBD65A23CD1BED428B72C287AF2E9DFA@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hello Joakim,

I successfully validated your CAN FD support on an S32V234 based board.
Here are some points which are not very clear to me:

Joakim Zhang <qiangqing.zhang@nxp.com> writes:
> +		priv->write(reg_mcr | FLEXCAN_MCR_FDEN, &regs->mcr);

According to the S32V234 reference manual (not sure if this applies to
i.MX8QM as well), CAN_CTRL1[SMP] cannot be asserted when CAN FD is
enabled. Is it safe to configure the interface with both "fd on" and
"triple-sampling on"? If not, flexcan_open should return an error when
both CAN_CTRLMODE_FD and CAN_CTRLMODE_3_SAMPLES are set in ctrlmode.

Joakim Zhang <qiangqing.zhang@nxp.com> writes:
> +		priv->offload.is_canfd =3D true;

Shouldn't is_canfd be assigned false in the "else" branch? Otherwise,
is_canfd will stay true after the following sequence:

root@s32v234evb:~# ip link set can0 type can bitrate 500000 dbitrate
2000000 fd on
root@s32v234evb:~# ip link set can0 up
root@s32v234evb:~# ip link set can0 down
root@s32v234evb:~# ip link set can0 type can bitrate 500000 fd off
root@s32v234evb:~# ip link set can0 up

Moreover, I wonder if we even need is_canfd, because frames should be
fed to the kernel as classic or FD based only on the EDL bit in the C/S
word of the Rx MB, to keep their original format. That is, you may
either read EDL from within a new callback (but I think that
mailbox_read should remain the only one which both locks and unlocks the
mailboxes) or let mailbox_read call alloc_can(fd)_skb itself.

Regards,
Stefan
