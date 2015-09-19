From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: RE: J1939 + iMX6 + yocto
Date: Sat, 19 Sep 2015 08:34:35 +0200
Message-ID: <5E00F3EF-2CEB-4BCE-9D73-BB4EE40ED851@vandijck-laurijssen.be>
References: <20141212110743.GC10796@vandijck-laurijssen.be> <20150519084626.GC1088@vandijck-laurijssen.be> <18596_1441369456_55E98D70_18596_3092_1_F1366246CF364C42B98553900CE0C5CB089DBAF9@OPEXCLILM23.corporate.adroot.infra.ftgroup> <36853685-8336-4C81-88CE-AE3CB1A36AFA@vandijck-laurijssen.be> <12979_1441607513_55ED2F59_12979_6_1_F1366246CF364C42B98553900CE0C5CB089DBBE6@OPEXCLILM23.corporate.adroot.infra.ftgroup> <20150908075800.GA864@airbook.eia.lan> <22033_1441704817_55EEAB71_22033_5373_1_F1366246CF364C42B98553900CE0C5CB089DBCCA@OPEXCLILM23.corporate.adroot.infra.ftgroup> <20150908123249.GC25796@airbook.eia.lan> <19625_1442567071_55FBD39E_19625_433_1_a28ef7d8-1702-43c1-afda-ae52611932b1@OPEXCLILM7E.corporate.adroot.infra.ftgroup> <C1AAF45F-6C7C-4AB1-93E3-3FEE36B5CF83@vandijck-laurijssen.b
 e> <31941_1442579383_55FC03B7_31941_497_6_3c5ee703-7ff1-4f6c-8da3-b02d7f2c1939@OPEXCLILM7D.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:16677 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbISGej (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 19 Sep 2015 02:34:39 -0400
In-Reply-To: <31941_1442579383_55FC03B7_31941_497_6_3c5ee703-7ff1-4f6c-8da3-b02d7f2c1939@OPEXCLILM7D.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 18 September 2015 14:29:40 CEST, pfifre.ext@orange.com wrote:
>Hi Kurt,
>
>That's the question: the patch seems to be build, but, this warning :
>"either "dev" is duplicate, or "j1939" is a garbage" seems that no
>patch has been done on the final distribution, no?
>I remember that this warning comes with the absence of iproute2-j1939
>patch. It is right?
>

Yes, you're right

>I verified the iproute2-j1939 recipe alone and it works fine.
>I think the patch won't be correctly done with the global recipe.
>

So this becomes a pure yocto issue.
Are you sure that 'ip' tool on the rootfs is from busybox or iproute2?

Kurt

>Best regards,
>
>Pascal
>
>
>-----Message d'origine-----
>De=C2=A0: Kurt Van Dijck [mailto:dev.kurt@vandijck-laurijssen.be]=20
>Envoy=C3=A9=C2=A0: vendredi 18 septembre 2015 14:11
>=C3=80=C2=A0: FIFRE Pascal Ext IMT/OLPS
>Cc=C2=A0: linux-can@vger.kernel.org
>Objet=C2=A0: RE: J1939 + iMX6 + yocto
>
>
>
>On 18 September 2015 11:04:29 CEST, pfifre.ext@orange.com wrote:
>>Hi Kurt,
>>
>>I add the Yocto patch yesterday in my distribution.
>>It's very strange, because it seems to be applied on build (it appear=
s
>
>>on the Build without errors) but not on the distribution: I can't add=
=20
>>any j1939 link (either "dev" is duplicate, or "j1939" is a garbage).
>
>The warning comes from iproute2. Did you patch that already?
>
>>Apparently, bitbake finds the necessary files.
>>I have just one warning at build : the file=20
>>file://0001-ip-link-Remove-unnecessary-device-checking.patch doesn't
>be=20
>>found by the build (not present on poky, then I removed this line in=20
>>the bb).
>>
>>In fact, I notice that the git command in the bb doesn't work. I have=
=20
>>made a voluntary error in the path and the build ran with no errors.
>>Then, your patch is no applied to the distribution.
>>
>>Do you have any idea?
>>
>>It's the last task I have to do to run all the features of my=20
>>application.
>>
>>Thanks for your support.
>>
>>Best regards,
>>
>>Pascal
>>
>
>Sent from a small mobile device
>
>______________________________________________________________________=
___________________________________________________
>
>Ce message et ses pieces jointes peuvent contenir des informations
>confidentielles ou privilegiees et ne doivent donc
>pas etre diffuses, exploites ou copies sans autorisation. Si vous avez
>recu ce message par erreur, veuillez le signaler
>a l'expediteur et le detruire ainsi que les pieces jointes. Les
>messages electroniques etant susceptibles d'alteration,
>Orange decline toute responsabilite si ce message a ete altere, deform=
e
>ou falsifie. Merci.
>
>This message and its attachments may contain confidential or privilege=
d
>information that may be protected by law;
>they should not be distributed, used or copied without authorisation.
>If you have received this email in error, please notify the sender and
>delete this message and its attachments.
>As emails may be altered, Orange is not liable for messages that have
>been modified, changed or falsified.
>Thank you.

Sent from a small mobile device
