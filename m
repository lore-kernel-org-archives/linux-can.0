From: Simon Horman <simon.horman@netronome.com>
Subject: Re: [PATCH v2] can: m_can: add support for handling arbitration error
Date: Fri, 25 Oct 2019 13:16:27 +0200
Message-ID: <20191025111626.GA31153@netronome.com>
References: <CGME20191021121350epcas5p3313e54a3bc5c8600c52a6db299893f78@epcas5p3.samsung.com>
 <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
Sender: netdev-owner@vger.kernel.org
To: Pankaj Sharma <pankj.sharma@samsung.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, jhofstee@victronenergy.com, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

On Mon, Oct 21, 2019 at 05:43:36PM +0530, Pankaj Sharma wrote:
> The Bosch MCAN hardware (3.1.0 and above) supports interrupt flag to
> detect Protocol error in arbitration phase.
> 
> Transmit error statistics is currently not updated from the MCAN driver.
> Protocol error in arbitration phase is a TX error and the network
> statistics should be updated accordingly.
> 
> The member "tx_error" of "struct net_device_stats" should be incremented
> as arbitration is a transmit protocol error. Also "arbitration_lost" of
> "struct can_device_stats" should be incremented to report arbitration
> lost.
> 
> Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> ---
> 
> changes in v2:
> - common m_can_ prefix for is_protocol_err function
> - handling stats even if the allocation of the skb fails
> - resolving build errors on net-next branch

No objections from my side.
