From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v4 0/6] CTU CAN FD open-source IP core SocketCAN driver,
 PCI, platform integration and documentation
Date: Mon, 3 Aug 2020 13:29:49 -0700
Message-ID: <20200803132949.64884ff1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1596408856.git.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1596408856.git.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: pisa@cmp.felk.cvut.cz
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, mkl@pengutronix.de, socketcan@hartkopp.net, wg@grandegger.com, davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com, c.emde@osadl.org, armbru@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com, ondrej.ille@gmail.com, jnovak@fel.cvut.cz, jara.beran@gmail.com, porazil@pikron.com
List-Id: linux-can.vger.kernel.org

On Mon,  3 Aug 2020 20:34:48 +0200 pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> This driver adds support for the CTU CAN FD open-source IP core.
> More documentation and core sources at project page
> (https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core).
> The core integration to Xilinx Zynq system as platform driver
> is available (https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top).
> Implementation on Intel FPGA based PCI Express board is available
> from project (https://gitlab.fel.cvut.cz/canbus/pcie-ctu_can_fd).
> The CTU CAN FD core emulation send for review for QEMU mainline.
> Development repository for QEMU emulation - ctu-canfd branch of
>   https://gitlab.fel.cvut.cz/canbus/qemu-canbus
> 
> More about CAN related projects used and developed at the Faculty
> of the Electrical Engineering (http://www.fel.cvut.cz/en/)
> of Czech Technical University (https://www.cvut.cz/en)
> in Prague at http://canbus.pages.fel.cvut.cz/ .

Patches 3 and 4 have warnings when built with W=1 C=1 flags.

Please also remove the uses of static inline in C sources.
Those are rarely necessary and hide unused code warnings.
