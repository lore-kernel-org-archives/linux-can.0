From: Dan Murphy <dmurphy@ti.com>
Subject: Re: tcan4x5x on a Raspberry Pi
Date: Mon, 29 Jul 2019 13:07:06 -0500
Message-ID: <d1badcdb-7635-705d-35d5-448297e8fafa@ti.com>
References: <845ea24f71b74b42821c7fce20bc0476@escrypt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <845ea24f71b74b42821c7fce20bc0476@escrypt.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)" <fixed-term.Konstantin.Buecheler@escrypt.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Konstantin

On 7/29/19 6:19 AM, FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu) wrote:
> Hi all,
>
> I am currently working on a project where I am trying to use the tcan4550 chip with a Raspberry PI 3B.
> I am struggling to create a working device tree overlay file for the Raspberry Pi.
> Has anyone here tried this already? I would appreciate any help.

Are you using the driver from net-next?

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/drivers/net/can/m_can

DT documentation here

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/Documentation/devicetree/bindings/net/can/tcan4x5x.txt

I did the development on a BeagleBone Black.

Dan

> Thanks,
> Konstantin
>
