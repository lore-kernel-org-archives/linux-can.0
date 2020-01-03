From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Date: Fri, 3 Jan 2020 16:53:59 -0700
Message-ID: <20200103235359.GA23875@bogus>
References: <cover.1576922226.git.pisa@cmp.felk.cvut.cz>
 <61533d59378822f8c808abf193b40070810d3d35.1576922226.git.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61533d59378822f8c808abf193b40070810d3d35.1576922226.git.pisa@cmp.felk.cvut.cz>
Sender: netdev-owner@vger.kernel.org
To: pisa@cmp.felk.cvut.cz
Cc: devicetree@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com, davem@davemloft.net, mark.rutland@arm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com, ondrej.ille@gmail.com, jnovak@fel.cvut.cz, jara.beran@gmail.com, porazil@pikron.com
List-Id: linux-can.vger.kernel.org

On Sat, Dec 21, 2019 at 03:07:31PM +0100, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt

Bindings are moving DT schema format now. Not something I'd require on a 
respin I've already reviewed, but OTOH it's been 10 months to respin 
from v2. So:

Reviewed-by: Rob Herring <robh@kernel.org>

If you have a v4, then please convert to a schema.

Rob
