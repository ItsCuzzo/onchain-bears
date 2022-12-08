// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/OnChainBears.sol";

contract OnChainBearsTest is Test {
    using stdJson for string;

    struct TraitData {
        string pixels;
        string name;
        string value;
    }

    OnChainBears public ocb;

    string[6] public files = [
        "hats", "eyes", "noses", "mouths", "furs", "backgrounds"
    ];

    uint256[6] public counts = [
        16, 15, 3, 12, 10, 11
    ];

    address public constant ALICE = address(0xbabe);

    modifier startMint {
        ocb.enableMint();
        _;
    }

    modifier addTraits {

        string memory json;
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits;
        
        uint256 count;

        for (uint256 i = 0; i < files.length; i++) {

            json = vm.readFile(string(abi.encodePacked(
                "./traits/", files[i], ".json"
            )));

            traits = new OnChainBears.Trait[](counts[i]);

            for (uint256 j = 0; j < counts[i]; j++) {

                data = json.parseRaw(string(abi.encodePacked(
                    ".[", vm.toString(j), "]"
                )));

                traitData = abi.decode(data, (TraitData));

                traits[j] = OnChainBears.Trait({
                    name: traitData.name,
                    value: traitData.value,
                    pixels: traitData.pixels
                });

            }

            ocb.addTraits(i, traits);

        }

        _;
    }

    function setUp() public {
        ocb = new OnChainBears();
    }

    function testMint() public addTraits startMint {
        for (uint256 i = 0; i < 250; i++) {
            address account = address(uint160(i+1));

            hoax(account, account);
            ocb.mint(2);

            uint256 balance = ocb.balanceOf(account);
            assertEq(balance, 2);
        }

        ocb.tokenURI(1);
    }

    function testCannotMintNonEOA() public addTraits {
        vm.expectRevert(IOnChainBears.NonEOA.selector);
        ocb.mint(1);
    }

    function testCannotMintInvalidAmount() public addTraits {
        hoax(ALICE, ALICE);
        vm.expectRevert(IOnChainBears.InvalidAmount.selector);
        ocb.mint(3);
    }

    function testCannotMintOverMaxSupply() public addTraits startMint {
        for (uint256 i = 0; i < 500; i++) {
            address account = address(uint160(i+1));
            hoax(account, account);
            ocb.mint(2);
        }

        hoax(ALICE, ALICE);
        vm.expectRevert(IOnChainBears.OverMaxSupply.selector);
        ocb.mint(1);
    }

    function testAddTraitsHats() public {
        string memory json = vm.readFile('./traits/hats.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](16);

        for (uint256 id = 0; id < 16; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(0, traits);

        (
            string memory name,
            string memory value,
            string memory pixels
        ) = ocb.traits(0, 0);

        assertEq(name, "Hat");
        assertEq(value, "None");
        assertEq(pixels, "");
    }

    function testAddTraitsEyes() public {
        string memory json = vm.readFile('./traits/eyes.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](15);

        for (uint256 id = 0; id < 15; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(1, traits);

        (
            string memory name,
            string memory value,
            string memory pixels
        ) = ocb.traits(1, 0);

        assertEq(name, "Eyes");
        assertEq(value, "Deal With It");
        assertEq(pixels, "fl51gl51gm51hl51hm51hn51il59im51in59jl51jm59jn51kl59km51ll51ml51nl51nm51ol51om51on51pl59pm51pn59ql51qm59qn51rl59rm51sl51");
    }

    function testAddTraitsNoses() public {
        string memory json = vm.readFile('./traits/noses.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](3);

        for (uint256 id = 0; id < 3; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(2, traits);

        (
            string memory name,
            string memory value,
            string memory pixels
        ) = ocb.traits(2, 0);

        assertEq(name, "Nose");
        assertEq(value, "Pink");
        assertEq(pixels, "lq58mq58");
    }

    function testAddTraitsMouths() public {
        string memory json = vm.readFile('./traits/mouths.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](12);

        for (uint256 id = 0; id < 12; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(3, traits);

        (
            string memory name,
            string memory value,
            string memory pixels
        ) = ocb.traits(3, 0);

        assertEq(name, "Mouth");
        assertEq(value, "Cute");
        assertEq(pixels, "is42jt42kt42ls42ms42nt42ot42ps42");
    }

    function testAddTraitsFurs() public {
        string memory json = vm.readFile('./traits/furs.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](10);

        for (uint256 id = 0; id < 10; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(4, traits);

        (
            string memory name,
            string memory value,
            string memory pixels
        ) = ocb.traits(4, 0);

        assertEq(name, "Fur");
        assertEq(value, "Green");
        assertEq(pixels, "do42dp42dq42dr42ds42eh42ei42ej42en42eo65ep65eq65er65es65et42fg42fh65fi65fj65fk42fl42fm42fn65fo65fp65fq65fr65fs65ft65fu42gf42gg65gh62gi62gj65gk65gl65gm65gn65go65gp65gq65gr65gs65gt65gu42hf42hg65hh65hi65hj65hk65hl65hm65hn65ho65hp65hq65hr65hs65ht65hu65hv42ig42ih42ii42ij65ik65il65im65in65io65ip65iq65ir65is65it65iu65iv42ji42jj65jk65jl65jm65jn65jo65jp65jq65jr65js65jt65ju65jv42kh42ki65kj65kk65kl65km65kn65ko65kp65kq65kr65ks65kt65ku65kv65kw42lh42li65lj65lk65ll65lm65ln65lo65lp65lq65lr65ls65lt65lu65lv65lw42mh42mi65mj65mk65ml65mm65mn65mo65mp65mq65mr65ms65mt65mu65mv65mw42nh42ni65nj65nk65nl65nm65nn65no65np65nq65nr65ns65nt65nu65nv65nw42oi42oj65ok65ol65om65on65oo65op65oq65or65os65ot65ou65ov42pg42ph42pi42pj65pk65pl65pm65pn65po65pp65pq65pr65ps65pt65pu65pv42qf42qg65qh65qi65qj65qk65ql65qm65qn65qo65qp65qq65qr65qs65qt65qu65qv42rf42rg65rh62ri62rj65rk65rl65rm65rn65ro65rp65rq65rr65rs65rt65ru42sg42sh65si65sj65sk42sl42sm42sn65so65sp65sq65sr65ss65st65su42th42ti42tj42tn42to65tp65tq65tr65ts65tt42uo42up42uq42ur42us42");
    }

    function testAddTraitsBackgrounds() public {
        string memory json = vm.readFile('./traits/backgrounds.json');
        bytes memory data;

        TraitData memory traitData;
        OnChainBears.Trait[] memory traits = new OnChainBears.Trait[](11);

        for (uint256 id = 0; id < 11; id++) {
            data = json.parseRaw(string(abi.encodePacked(
                ".[", vm.toString(id), "]"
            )));
            
            traitData = abi.decode(data, (TraitData));
            
            traits[id] = OnChainBears.Trait(
                traitData.name,
                traitData.value,
                traitData.pixels
            );
        }

        ocb.addTraits(5, traits);

        (
            string memory name,
            string memory value,
            string memory pixels
        ) = ocb.traits(5, 0);

        assertEq(name, "Background");
        assertEq(value, "Cryptoadz");
        assertEq(pixels, "aa03ab03ac03ad03ae03af03ag03ah03ai03aj03ak03al03am03an03ao03ap03aq03ar03as03at03au03av03aw03ax03ba03bb03bc59bd03be03bf03bg03bh03bi03bj03bk03bl03bm03bn03bo03bp03bq03br03bs03bt03bu03bv03bw03bx03ca03cb03cc03cd42ce42cf03cg03ch03ci03cj03ck03cl03cm03cn03co03cp03cq03cr03cs03ct03cu03cv03cw03cx03da03db03dc03dd42de42df03dg03dh03di03dj03dk03dl03dm03dn03dt03du03dv03dw03dx03ea03eb03ec59ed03ee03ef03eg03ek03el03em03eu03ev03ew03ex03fa03fb03fc03fd03fe03ff03fv03fw03fx03ga03gb03gc03gd03ge03gv03gw03gx03ha03hb03hc03hd03he03hw03hx03ia03ib03ic03id03ie03if03iw03ix03ja03jb03jc03jd03je03jf03jg03jh03jw03jx03ka03kb03kc03kd03ke03kf03kg03kx03la03lb03lc03ld03le03lf03lg03lx03ma03mb03mc03md03me03mf03mg03mx03na03nb03nc03nd03ne03nf03ng03nx03oa03ob03oc03od03oe03of03og03oh03ow03ox03pa03pb03pc03pd03pe03pf03pw03px03qa03qb03qc03qd03qe03qw03qx03ra03rb03rc03rd03re03rv03rw03rx03sa03sb03sc03sd03se03sf03sv03sw03sx03ta03tb03tc03td03te03tf03tg03tk03tl03tm03tu03tv03tw03tx03ua03ub59uc42ud42ue03uf03ug03uh03ui03uj03uk03ul03um03un03ut03uu03uv03uw03ux03va03vb03vc42vd42ve03vf03vg03vh03vi03vj03vk03vl03vm03vn03vo03vp03vq03vr03vs03vt03vu03vv03vw03vx03wa03wb59wc03wd03we03wf03wg03wh03wi03wj03wk03wl03wm03wn03wo03wp03wq03wr03ws03wt03wu03wv03ww03wx03xa03xb03xc03xd03xe03xf03xg03xh03xi03xj03xk03xl03xm03xn03xo03xp03xq03xr03xs03xt03xu03xv03xw03xx03");
    }

    function testCannotAddTraitsNonOwner() public {
        OnChainBears.Trait[] memory trait;

        hoax(ALICE, ALICE);
        vm.expectRevert(abi.encodeWithSignature("Unauthorized()"));
        ocb.addTraits(0, trait);
    }

}
