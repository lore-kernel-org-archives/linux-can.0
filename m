From: Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: RE: [PATCH 0/2] can: xilinx_can: Bug fixes on can driver
Date: Wed, 20 Nov 2019 15:54:10 +0000
Message-ID: <MN2PR02MB64002F223821E7BD940B4E54DC4F0@MN2PR02MB6400.namprd02.prod.outlook.com>
References: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
 <e985fd5a-9b0c-f273-d28c-14515dc25e5c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e985fd5a-9b0c-f273-d28c-14515dc25e5c@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Srinivas Neeli <sneeli@xilinx.com>, Michal Simek <michals@xilinx.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Naga Sureshkumar Relli <nagasure@xilinx.com>, git <git@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-can.vger.kernel.org

Hi Marc,

> 
> On 11/20/19 1:11 PM, Srinivas Neeli wrote:
> > This patch series does the following:
> > -skip printing error message on deferred probe -Fix usage of skb
> > memory
> 
> BTW: I'm looking for an official Maintainer for the xlinx_can driver.
> 
> The Maintainer will get an entry in the MAINTAINERS file, should test new
> patches and give Reviewed-bys.
> 
> Is there a volunteer?

Sure will volunteer the maintainership, will send the maintainer fragment patch... 

Regards,
Kedar.
> 
> regards,
> Marc
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
